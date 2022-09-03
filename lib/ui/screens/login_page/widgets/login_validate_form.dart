import 'package:flutter/material.dart';
import 'package:katra/api_manager/api_functions.dart';
import 'package:katra/constant/color.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/di/locator.dart';
import 'package:katra/ui/screens/login_page/login_bloc.dart';
import 'package:katra/ui/screens/signup_page/signup_page.dart';
import 'package:katra/ui/widgets/blue_text.dart';
import 'package:katra/ui/widgets/button.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/validator_email_field.dart';
import 'package:katra/ui/widgets/validator_password_field.dart';

import '../../forget_password_page/forget_password_page.dart';
import '../../homepage_page/homepage_page.dart';

class LoginValidateForm extends StatelessWidget {
  LoginValidateForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  TextEditingController _validateEmailController = TextEditingController();
  TextEditingController _validatePasswordController = TextEditingController();
  final LoginBloc _loginBloc = getItLocator.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              ValidatorEmailField(
                hintText: "Email",
                submit: _submitted,
                validatorController: _validateEmailController,
              ),
              ValidatorPasswordField(
                  hintText: "Password",
                  submit: _submitted,
                  validatorController: _validatePasswordController),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
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
              SizedBoxes.verticalBig,
              //SizedBoxes.verticalExtraGargangua,
              UI_Button(
                buttonText: "Login",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // _loginBloc.loginPost();
                    //_loginBloc.loginPost();

                    apiFunctions.login(
                      emailController: _validateEmailController,
                      passwordController: _validatePasswordController,
                    );

                    await Future.delayed(Duration(seconds: 4)).then(
                      (value) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomepagePage(),
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBoxes.verticalTiny,
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
                    buttonText: "Sign Up",
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
      ),
    );
  }
}
