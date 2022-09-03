import 'dart:async';

import 'package:katra/api_manager/response.dart';
import 'package:katra/constant/strings_ui.dart';
import 'package:katra/models/response/signup.dart';
import 'package:katra/repos/signup_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:katra/base/validation_rules.dart';

class SignupBloc with ValidationRules {
  final SignupRepo _signupRepo;

  SignupBloc(this._signupRepo);

  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  late final results;

  //streams
  Stream<String> get name => _name.stream.transform(signupName);

  Stream<String> get email => _email.stream.transform(emailValidation);

  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(signupPhoneNumber);

  Stream<String> get password => _password.stream.transform(signupPassword);

  Stream<String> get confirmPassword => _confirmPassword.stream
          .transform(signupConfirmPassword)
          .doOnData((String c) {
        // If the password is accepted (after validation of the rules)
        // we need to ensure both password and retyped password match
        if (0 != _password.value.compareTo(c)) {
          // If they do not match, add an error
          _confirmPassword.addError(StringsUI.signupConfirmPasswordError);
        }
      });

  // Monitor Any Changes in the Text Fields
  StreamSink get nameChanges => _name.sink;

  StreamSink get emailChanges => _email.sink;

  StreamSink get phoneNumberChanges => _phoneNumber.sink;

  StreamSink get passwordChanges => _password.sink;

  StreamSink get confirmPasswordChanges => _confirmPassword.sink;

  Stream<bool> get submitButtonIsValid {
    return Rx.combineLatest5(
      name,
      email,
      phoneNumber,
      password,
      confirmPassword,
      (nameValue, emailValue, phoneNumberValue, passwordValue,
          confirmPasswordValue) {
        return true;
      },
    );
  }

  Future<APIResponse<Signup>> SignupPost() async {
    final result = await _signupRepo.signupPost(
      name: _name.value.toString(),
      email: _email.value.toString(),
      phoneNumber: _phoneNumber.value.toString(),
      password: _password.value.toString(),
      confirmPassword: _confirmPassword.value.toString(),
    );
    //print(result.statusCode);
    return result;
  }

  dispose() {
    _name.close();
    _email.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }
}
