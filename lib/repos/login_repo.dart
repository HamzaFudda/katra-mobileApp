import 'dart:convert';

import 'package:katra/api_manager/client.dart';
import 'package:http/http.dart' as http;
import 'package:katra/api_manager/network_services.dart';

import '../api_manager/response.dart';
import '../constant/prefrence_key.dart';
import '../db_manager/local_storage_service.dart';
import '../models/response/login.dart';
import '../models/response/user_location.dart';

class LoginRepo {
  final Client serviceClient;
  String? accessToken;
  String? refreshToken;

  LoginRepo(this.serviceClient);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    print(email);
    print(password);
    var response = await http.post(
      //Uri.parse("https://reqres.in/api/login"),
      Uri.parse(NetworkServices.baseURL + NetworkServices.login),
      body: ({
        "email": email,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      print("api test successful");
    } else {
      print(response.statusCode);
    }
  }

  // Future<APIResponse<Login>> postLogin({
  //   required String email,
  //   required String password,
  // }) async {
  //   final response = await serviceClient.postNetworkRequest(
  //     Uri.parse(NetworkServices.baseURL + NetworkServices.login),
  //     ({
  //       "email": email,
  //       "password": password,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print("api test successful");
  //   } else {
  //     print(response.statusCode);
  //   }
  //   final result = jsonDecode(response.body);
  //   final sd = APIResponse<Login>.fromJson(
  //       result,
  //           (data) =>
  //      Login.fromJson(data));
  //   return sd;
  // }

  Future<APIResponse<Login>> postLogin({
    required String email,
    required String password,
  }) async {
    final response = await serviceClient.postNetworkRequest(
      Uri.parse(NetworkServices.baseURL + NetworkServices.login),
      ({
        "email": email,
        "password": password,
      }),
    );
    final sd = APIResponse<Login>.fromJson(
      response,
      (data) {
        return Login.fromJson(data);
      },
    );
    //print("access token" + sd.data!.accessToken.toString());

    return sd;
  }

  Future<APIResponse<UserLocation>> postLocation(
      {required String long, required String lat}) async {

    final response = await serviceClient.postNetworkRequest(
      Uri.parse(NetworkServices.baseURL + NetworkServices.userLocation),
      {
        'long': long,
        'lat': lat,
      },
      {
        'auth-token': accessToken!,
      },
    );
    final sd = APIResponse<UserLocation>.fromJson(
      response,
      (data) {
        return UserLocation.fromJson(data);
      },
    );
    //print();
    // print("response " + accessToken!);
    // var response2 = await http.post(
    //   Uri.parse("http://katra-lb-314246082.us-east-1.elb.amazonaws.com:5000/api/v1/insertUserLocation"),
    //   body:{
    //     'long': long,
    //     'lat': lat,
    //   },
    //   headers:{
    //     'auth-token': accessToken!,
    //     //"Content-Type":"application/x-www-form-urlencoded",
    //
    //   },
    // );
    // print("response " + response2.body.toString());

    return sd;
  }

  getToken() async {
    var object =
        await SharedPreferenceUtil.getData(key: PreferenceKeys.loginKey);
    if (object != null) {
      var response = Login.fromJson(object);
      accessToken = response.accessToken;
      refreshToken = response.refreshToken;
      return response;
    } else {
      return null;
    }
  }
}
