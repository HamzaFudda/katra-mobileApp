import 'package:katra/base/validation_rules.dart';
import 'package:katra/repos/login_repo.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import '../../../api_manager/response.dart';
import '../../../models/response/login.dart';

class LoginBloc with ValidationRules {
  final LoginRepo _loginRepo;

  LoginBloc(this._loginRepo);

  //Behaviour subjects with stream Controllers
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  late final results;

  //streams
  Stream<String> get email => _email.stream.transform(loginField);

  Stream<String> get password => _password.stream.transform(loginField);

  Stream<bool> get submitButtonIsValid {
    return Rx.combineLatest2(
      email,
      password,
      (emailValue, passwordValue) {
        return true;
      },
    );
  }

  // Monitor Any Changes in the Text Fields
  StreamSink get emailChanges => _email.sink;

  StreamSink get passwordChanges => _password.sink;

  String get emailVals => _email.value.toString();

  Future<APIResponse<Login>> loginPost() async {
    final result = await _loginRepo.postLogin(
      email: _email.value,
      password: _password.value,
    );
    return result;
  }

  Future<void> locationService() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    //print(_locationData.longitude.toString());
    final result = await _loginRepo.postLocation(
      long: _locationData.longitude.toString(),
      lat: _locationData.latitude.toString(),
    );
    // print("user location status response" + result.statusCode.toString());
    // print("user location status response" + result.data.toString());
  }

  submitLogin() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email: $validEmail');
    print('Password: $validPassword');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
