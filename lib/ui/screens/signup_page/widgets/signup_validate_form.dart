import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katra/api_manager/api_functions.dart';
import 'package:katra/di/locator.dart';
import 'package:katra/ui/screens/login_page/login_page.dart';
import 'package:katra/ui/screens/signup_page/signup_bloc.dart';
import 'package:katra/ui/widgets/validator_password_field.dart';
import 'package:katra/ui/widgets/validator_text_field.dart';

import '../../../../constant/color.dart';
import '../../../../constant/sized_boxes.dart';
import '../../../widgets/blue_text.dart';
import '../../../widgets/button.dart';
import '../../../widgets/inter_text.dart';
import '../../../widgets/validator_email_field.dart';
import '../../homepage_page/homepage_page.dart';
import '../signup_page.dart';


class SignUpValidateForm extends StatelessWidget {
  SignUpValidateForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  TextEditingController _validateNameController = TextEditingController();
  TextEditingController _validatePhoneNumberController =
      TextEditingController();
  TextEditingController _validateEmailController = TextEditingController();
  TextEditingController _validatePasswordController = TextEditingController();
  TextEditingController _validateConfirmPasswordController =
      TextEditingController();

  final SignupBloc _signupBloc = getItLocator.get<SignupBloc>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValidatorTextField(
                hintText: "Name",
                submit: _submitted,
                 validatorController: _validateNameController,
                isRequired: true,
              ),
              ValidatorEmailField(
                hintText: "Email",
                submit: _submitted,
                validatorController: _validateEmailController,
              ),
              ValidatorTextField(
                hintText: "Phone Number",
                submit: _submitted,
                validatorController: _validatePhoneNumberController,
              ),
              ValidatorPasswordField(
                hintText: "Password",
                submit: _submitted,
                validatorController: _validatePasswordController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 4),
                child: InterText(
                  text:
                      "Must contain\nOne uppercase letter, one lower case letter and one number.",
                  fontSize: 11,
                  color: ColorConstants.grey_text_color,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBoxes.verticalTiny,
              ValidatorPasswordField(
                hintText: "Confirm Password",
                submit: _submitted,
                validatorController: _validateConfirmPasswordController,
              ),
            ],
          ),
          SizedBoxes.verticalGargangua,
          Column(
            children: [
              SizedBoxes.verticalBig,
              //SizedBoxes.verticalExtraGargangua,
              UI_Button(
                buttonText: "Sign Up",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //Navigator.pop(context);
                    apiFunctions.register(
                        nameController: _validateNameController,
                        emailController: _validateEmailController,
                        phoneNumberController: _validatePhoneNumberController,
                        passwordController: _validatePasswordController,
                        confirmPasswordController:
                            _validateConfirmPasswordController);
                    //_signupBloc.SignupPost();

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
              SizedBoxes.verticalMedium,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     InterText(
              //       text: "Already have an account?  ",
              //       fontSize: 16,
              //       color: ColorConstants.grey_text_color,
              //     ),
              //     BlueText(
              //       buttonText: "Login",
              //       onTap: () {
              //         Navigator.of(context).pop();
              //         // Navigator.of(context).push(
              //         //   MaterialPageRoute(
              //         //     builder: (context) => LoginPage(),
              //         //   ),
              //         // );
              //       },
              //       fontSize: 16,
              //     )
              //   ],
              // )
            ],
          ),
          SizedBoxes.verticalExtraGargangua,
          SizedBoxes.verticalGargangua,
        ],
      ),
    );
  }
}
