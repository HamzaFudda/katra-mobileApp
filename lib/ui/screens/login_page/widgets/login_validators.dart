import 'package:flutter/material.dart';
import 'package:katra/ui/screens/login_page/login_bloc.dart';
import 'package:katra/ui/widgets/email_field.dart';
import 'package:katra/ui/widgets/password_field.dart';
import 'package:katra/ui/widgets/stream_button.dart';

import '../../../../constant/color.dart';
import '../../../../constant/sized_boxes.dart';
import '../../../../di/locator.dart';
import '../../../widgets/blue_text.dart';
import '../../../widgets/button.dart';
import '../../../widgets/inter_text.dart';
import '../../../widgets/single_line_text_form_field.dart';
import '../../forget_password_page/forget_password_page.dart';
import '../../signup_page/signup_page.dart';

class LoginValidators extends StatelessWidget {
  LoginValidators({Key? key}) : super(key: key);
  LoginBloc _loginBloc = getItLocator.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            StreamBuilder<String>(
              stream: _loginBloc.email,
              builder: (context, snapshot) {
                return SingleLineTextFormField(
                  errorText: snapshot.error?.toString(),
                  textFieldHint: "Enter Email",
                  keyboardType: TextInputType.emailAddress,
                  isPassword: false,
                  onChanged: (value) {
                    _loginBloc.emailChanges.add(value);
                  },
                );
              },
            ),
            StreamBuilder<String>(
              stream: _loginBloc.password,
              builder: (context, snapshot) {
                return SingleLineTextFormField(
                  errorText: snapshot.error?.toString(),
                  textFieldHint: "Enter Email",
                  keyboardType: TextInputType.emailAddress,
                  isPassword: false,
                  onChanged: (value) {
                    _loginBloc.passwordChanges.add(value);
                  },
                );
              },
            ),
            // PasswordField(
            //     onChange: () {
            //       _loginBloc.passwordChanges;
            //     },
            //     blocStream: _loginBloc.password),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
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
            UI_Button(
              buttonText: "Login",
              onPressed: () {
                  _loginBloc.emailVals;
              },
            ),

            // StreamButton(
            //     buttonText: "Login",
            //     onPressed: () {
            //       _loginBloc.submitLogin();
            //     },
            //     blocStream: _loginBloc.submitButtonIsValid),

            SizedBoxes.verticalTiny,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InterText(
                  text: "Dont have an account?  ",
                  fontSize: 16,
                  color: ColorConstants.grey_text_color,
                ),
                BlueText(
                  buttonText: "SignUp",
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
          ],
        ),
      ],
    );
  }
}
