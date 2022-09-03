import 'dart:async';

import 'package:katra/constant/strings_ui.dart';

class ValidationRules {
  static String _EmailRule =
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
  static String _PasswordRule =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,16}$";

  final emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      final RegExp emailExp = new RegExp(_EmailRule);
      if (!emailExp.hasMatch(email) || email.isEmpty) {
        sink.addError(StringsUI.signupEmailError);
      } else {
        sink.add(email);
      }
    },
  );
  final signupPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      final RegExp passwordExp = new RegExp(_PasswordRule);
      if (!passwordExp.hasMatch(password)) {
        sink.addError(StringsUI.signupPasswordError);
      } else {
        sink.add(password);
      }
    },
  );

  final loginField = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      (email.isNotEmpty)
          ? sink.add(email)
          : sink.addError(StringsUI.loginError);
    },
  );
  final signupName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      (name.isNotEmpty)
          ? sink.add(name)
          : sink.addError(StringsUI.signupNameError);
    },
  );

  final signupPhoneNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (number, sink) {
      (number.isNotEmpty)
          ? sink.add(number)
          : sink.addError(StringsUI.signupPhoneNumberError);
    },
  );

  final signupConfirmPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (confirmPassword, sink) {
      (confirmPassword.isNotEmpty)
          ? sink.add(confirmPassword)
          : sink.addError('This field is mandatory.');
    },
  );

  final loginPasswordField = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      (password.isNotEmpty)
          ? sink.add(password)
          : sink.addError('This field is mandatory.');
    },
  );
}
