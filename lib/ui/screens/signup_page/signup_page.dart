import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/constant/strings_ui.dart';
import 'package:katra/di/locator.dart';
import 'package:katra/models/response/signup.dart';
import 'package:katra/ui/screens/signup_page/signup_bloc.dart';
import 'package:katra/ui/screens/signup_page/widgets/signup_validate_form.dart';
import 'package:katra/ui/widgets/button.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/poppins_text.dart';
import 'package:katra/ui/widgets/single_line_text_form_field.dart';

import '../../../api_manager/response.dart';
import '../../../constant/color.dart';
import '../homepage_page/homepage_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupBloc _signupBloc = getItLocator.get<SignupBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness:
          Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          StringsUI.signup,
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
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxes.verticalExtraGargangua,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _signupTexts(),
                SizedBoxes.verticalMedium,
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: StreamBuilder<String>(
                    stream: _signupBloc.name,
                    builder: (context, snapshot) {
                      return SingleLineTextFormField(
                        textFieldHint: StringsUI.name,
                        errorText: snapshot.error?.toString(),
                        keyboardType: TextInputType.name,
                        isPassword: false,
                        onChanged: (value) {
                          _signupBloc.nameChanges.add(value);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: StreamBuilder<String>(
                    stream: _signupBloc.email,
                    builder: (context, snapshot) {
                      return SingleLineTextFormField(
                        textFieldHint: StringsUI.email,
                        errorText: snapshot.error?.toString(),
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        onChanged: (value) {
                          _signupBloc.emailChanges.add(value);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: StreamBuilder<String>(
                    stream: _signupBloc.phoneNumber,
                    builder: (context, snapshot) {
                      return SingleLineTextFormField(
                        textFieldHint: StringsUI.phoneNumber,
                        errorText: snapshot.error?.toString(),
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        onChanged: (value) {
                          _signupBloc.phoneNumberChanges.add(value);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: StreamBuilder<String>(
                    stream: _signupBloc.password,
                    builder: (context, snapshot) {
                      return SingleLineTextFormField(
                        textFieldHint: StringsUI.password,
                        errorText: snapshot.error?.toString(),
                        keyboardType: TextInputType.emailAddress,
                        isPassword: true,
                        eyeButton: true,
                        onChanged: (value) {
                          _signupBloc.passwordChanges.add(value);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 4),
                  child: InterText(
                    text: StringsUI.signupScreenPasswordCriteria,
                    fontSize: 11,
                    color: ColorConstants.grey_text_color,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBoxes.verticalTiny,
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: StreamBuilder<String>(
                    stream: _signupBloc.confirmPassword,
                    builder: (context, snapshot) {
                      return SingleLineTextFormField(
                        textFieldHint: StringsUI.confirmPassword,
                        errorText: snapshot.error?.toString(),
                        keyboardType: TextInputType.name,
                        isPassword: true,
                        eyeButton: true,
                        onChanged: (value) {
                          _signupBloc.confirmPasswordChanges.add(value);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBoxes.verticalGargangua,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<Object>(
                  stream: _signupBloc.submitButtonIsValid,
                  builder: (context, snapshot) {
                    return UI_Button(
                      buttonText: StringsUI.signup,
                      onPressed: (snapshot.hasData && snapshot.data == true)
                          ? () async {
                              APIResponse<Signup> response =
                                  await _signupBloc.SignupPost();
                              if (response.statusCode == 200) {
                                await Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response.message.toString()),
                                    duration: Duration(milliseconds: 1000),
                                  ),
                                );
                                await Future.delayed(
                                  Duration(seconds: 2),
                                ).then(
                                  (value) => Navigator.of(context).pop(),
                                );
                              } else {
                                await Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response.message.toString()),
                                    duration: Duration(milliseconds: 1000),
                                  ),
                                );
                              }
                            }
                          : () {},
                    );
                  },
                ),
              ],
            ),
            SizedBoxes.verticalMedium,
            SizedBoxes.verticalExtraGargangua,
            SizedBoxes.verticalGargangua,
          ],
        ),
      ),
    );
  }
}

class _signupTexts extends StatelessWidget {
  const _signupTexts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PoppinsText(
            text: StringsUI.signupScreenJoinUsText,
            fontSize: 24,
            color: ColorConstants.black_text_color,
          ),
          SizedBoxes.verticalTiny,
          InterText(
            text: StringsUI.signupScreenDescription,
            fontSize: 14,
            color: ColorConstants.grey_text_color,
          ),
        ],
      ),
    );
  }
}
