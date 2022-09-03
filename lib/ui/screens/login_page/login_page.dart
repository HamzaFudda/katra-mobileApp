import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:katra/constant/color.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/constant/strings_ui.dart';
import 'package:katra/helper/exitFunction.dart';
import 'package:katra/ui/screens/login_page/widgets/login_image.dart';
import 'package:katra/ui/screens/login_page/widgets/login_validate_form.dart';
import 'package:katra/ui/screens/login_page/widgets/login_validators.dart';
import 'package:katra/ui/screens/navbar_navigation_page/navbar_navigation_page.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/poppins_text.dart';
import 'package:http/http.dart' as http;

import '../../../api_manager/response.dart';
import '../../../constant/prefrence_key.dart';
import '../../../db_manager/local_storage_service.dart';
import '../../../di/locator.dart';
import '../../../models/response/login.dart';
import '../../../repos/login_repo.dart';
import '../../widgets/blue_text.dart';
import '../../widgets/button.dart';
import '../../widgets/single_line_text_form_field.dart';
import '../forget_password_page/forget_password_page.dart';
import '../homepage_page/homepage_page.dart';
import '../signup_page/signup_page.dart';
import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc = getItLocator.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      bool exit = await showExitPopup(context: context);
      if (exit) {
        SystemNavigator.pop();
      }
      return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          title: Text(
            StringsUI.login,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstants.app_bar_color,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginImage(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _loginScreenWelcome(),
                  _loginDescription(),
                  SizedBoxes.verticalTiny,
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: StreamBuilder<String>(
                          stream: _loginBloc.email,
                          builder: (context, snapshot) {
                            return SingleLineTextFormField(
                              errorText: snapshot.error?.toString(),
                              textFieldHint: StringsUI.email,
                              keyboardType: TextInputType.emailAddress,
                              isPassword: false,
                              onChanged: (value) {
                                _loginBloc.emailChanges.add(value);
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: StreamBuilder<String>(
                          stream: _loginBloc.password,
                          builder: (context, snapshot) {
                            return SingleLineTextFormField(
                              errorText: snapshot.error?.toString(),
                              textFieldHint: StringsUI.password,
                              eyeButton: true,
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              onChanged: (value) {
                                _loginBloc.passwordChanges.add(value);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 20, 8),
                        child: BlueText(
                          buttonText: "Forgot password?",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgetPasswordPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBoxes.verticalBig,
                      StreamBuilder<Object>(
                        stream: _loginBloc.submitButtonIsValid,
                        builder: (context, snapshot) {
                          return UI_Button(
                            buttonText: StringsUI.login,
                            onPressed: (snapshot.hasData &&
                                    snapshot.data == true)
                                ? () async {
                                    APIResponse<Login> response =
                                        await _loginBloc.loginPost();
                                    if (response.statusCode == 200) {
                                      await SharedPreferenceUtil.saveData(
                                        key: PreferenceKeys.loginKey,
                                        data: response.data!.toJson(),
                                      );
                                      await getItLocator
                                          .get<LoginRepo>()
                                          .getToken();
                                      await _loginBloc.locationService();

                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                              Text(response.message.toString()),
                                          duration:
                                              Duration(milliseconds: 1000),
                                        ),
                                      );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NavBarNavigationPage(),
                                        ),
                                      );
                                    } else {
                                      await Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                              Text(response.message.toString()),
                                          duration:
                                              Duration(milliseconds: 1000),
                                        ),
                                      );
                                    }
                                  }
                                : () {
                                    // print("hello");
                                  },
                          );
                        },
                      ),
                      SizedBoxes.verticalTiny,
                      SizedBoxes.verticalTiny,
                      OutlineUI_Button(
                        buttonText: "Explore as a guest",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NavBarNavigationPage(),
                            ),
                          );
                          setState(() {});
                        },
                      ),
                      SizedBoxes.verticalTiny,
                      SizedBoxes.verticalTiny,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterText(
                            text: StringsUI.dontHaveAccount,
                            fontSize: 16,
                            color: ColorConstants.grey_text_color,
                          ),
                          BlueText(
                            buttonText: StringsUI.signup,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBoxes.verticalExtraGargangua,
                      SizedBoxes.verticalExtraGargangua,
                      SizedBoxes.verticalExtraGargangua,
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _loginScreenWelcome extends StatelessWidget {
  const _loginScreenWelcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: PoppinsText(
        text: StringsUI.loginScreenWelcomeBack,
        fontSize: 24,
        color: ColorConstants.black_text_color,
      ),
    );
  }
}

class _loginDescription extends StatelessWidget {
  const _loginDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: InterText(
          text: StringsUI.loginScreenDescription,
          fontSize: 14,
          color: ColorConstants.grey_text_color),
    );
  }
}
