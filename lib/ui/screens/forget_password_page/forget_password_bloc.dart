import 'dart:async';

import 'package:katra/base/validation_rules.dart';
import 'package:katra/models/response/forgetpassword.dart';
import 'package:katra/repos/forget_password_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../../api_manager/response.dart';

class ForgetPasswordBloc with ValidationRules {
  final ForgetPasswordRepo _forgetPasswordRepo;

  ForgetPasswordBloc(this._forgetPasswordRepo);

  //Behaviour subjects with stream Controllers
  final _email = BehaviorSubject<String>();
  late final results;

  Stream<String> get email => _email.stream.transform(emailValidation);

  Stream<bool> get submitButtonIsValid {
    return Rx.combineLatest(
      [email],
      (emailValue) {
        return true;
      },
    );
  }

  //
  // Stream<bool> get submitButtonIsValid {
  //   return Rx.combineLatest(
  //     email,
  //
  //         (emailValue) {
  //       return true;
  //     },
  //   );
  // }
  StreamSink get emailChanges => _email.sink;

  Future<APIResponse<ForgetPassword>> forgetpasswordPost() async {
    final result = await _forgetPasswordRepo.postForget(
      email: _email.value,
    );
    //print(result);
    return result;
  }

  dispose() {
    _email.close();
  }
}
