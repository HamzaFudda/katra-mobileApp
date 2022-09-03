import 'package:flutter/material.dart';
import 'package:katra/api_manager/api_functions.dart';

import '../../../../constant/sized_boxes.dart';
import '../../../widgets/button.dart';
import '../../../widgets/validator_email_field.dart';

class ForgetValidateForm extends StatelessWidget {
  ForgetValidateForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  TextEditingController _validateEmailController = TextEditingController();

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
            ],
          ),
          Column(
            children: [
              SizedBoxes.verticalMedium,
              SizedBoxes.verticalExtraGargangua,
              UI_Button(
                buttonText: "Send Link",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //Navigator.pop(context);
                    apiFunctions.forgetPssword(
                        emailController: _validateEmailController);
                    await Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Link sent'),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                    await Future.delayed(Duration(seconds: 4))
                        .then((value) => Navigator.of(context).pop());
                  }
                },
              ),
              SizedBoxes.verticalTiny,
            ],
          ),
        ],
      ),
    );
  }
}
