import 'package:flutter/material.dart';
import 'package:katra/constant/assets.dart';
import 'package:katra/constant/strings_ui.dart';
import 'package:katra/di/locator.dart';
import 'package:katra/models/response/forgetpassword.dart';
import 'package:katra/ui/screens/forget_password_page/forget_password_bloc.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/poppins_text.dart';
import 'package:katra/ui/widgets/single_line_text_form_field.dart';

import '../../../api_manager/response.dart';
import '../../../constant/color.dart';
import '../../../constant/sized_boxes.dart';
import '../../widgets/button.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  ForgetPasswordBloc _forgetPasswordBloc =
      getItLocator.get<ForgetPasswordBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // title: Text(
        //   "Sign Up",
        //   style: GoogleFonts.poppins(
        //     textStyle: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.w500,
        //       color: ColorConstants.app_bar_color,
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 120,
                width: 270,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image(
                    image: AssetImage(ImageAssets.KatraPasswordLogo),
                  ),
                ),
              ),
            ),
            SizedBoxes.verticalGargangua,
            PoppinsText(
              text: StringsUI.forgetPasswordTitle,
              fontSize: 24,
              color: ColorConstants.black_text_color,
            ),
            SizedBoxes.verticalMedium,
            InterText(
              text: StringsUI.forgetPasswordDescription,
              fontSize: 14,
              color: ColorConstants.grey_text_color,
              textAlign: TextAlign.center,
            ),
            SizedBoxes.verticalGargangua,
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: StreamBuilder<Object>(
                    stream: _forgetPasswordBloc.email,
                    builder: (context, snapshot) {
                      return SingleLineTextFormField(
                        textFieldHint: StringsUI.email,
                        errorText: snapshot.error?.toString(),
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        onChanged: (value) {
                          _forgetPasswordBloc.emailChanges.add(value);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBoxes.verticalMedium,
                SizedBoxes.verticalExtraGargangua,
                StreamBuilder<Object>(
                    stream: _forgetPasswordBloc.submitButtonIsValid,
                    builder: (context, snapshot) {
                      return UI_Button(
                        buttonText: StringsUI.sendLink,
                        onPressed: (snapshot.hasData && snapshot.data == true)
                            ? () async {
                                APIResponse<ForgetPassword> response =
                                    await _forgetPasswordBloc
                                        .forgetpasswordPost();
                                if (response.statusCode == 200) {
                                  await Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(response.message.toString()),
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
                                      content:
                                          Text(response.message.toString()),
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  );
                                }
                              }
                            : () {},
                      );
                    }),
                SizedBoxes.verticalTiny,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
