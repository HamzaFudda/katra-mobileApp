import 'package:katra/api_manager/network_services.dart';

import '../api_manager/client.dart';
import 'package:http/http.dart' as http;

import '../api_manager/response.dart';
import '../models/response/login.dart';
import '../models/response/signup.dart';

class SignupRepo {
  final Client serviceClient;

  SignupRepo(this.serviceClient);

  static Future<void> signup({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    var response = await http.post(
      //Uri.parse("https://reqres.in/api/login"),
      Uri.parse(NetworkServices.baseURL + NetworkServices.signup),
      body: ({
        "fullName": name,
        "email": email,
        "password": password,
        "confirmedPassword": confirmPassword,
        "phoneNumber": phoneNumber,
      }),
    );
    if (response.statusCode == 200) {
      print("api test successful");
    } else {
      print(response.statusCode);
    }
  }

  Future<APIResponse<Signup>> signupPost({
    required String? name,
    required String? email,
    required String? phoneNumber,
    required String? password,
    required String? confirmPassword,
  }) async {
    final response = await serviceClient.postNetworkRequest(
      Uri.parse(NetworkServices.baseURL + NetworkServices.signup),
      ({
        "fullName": name,
        "email": email,
        "password": password,
        "confirmedPassword": confirmPassword,
        "phoneNumber": phoneNumber,
      }),
    );

    //final result = response;
    final sd = APIResponse<Signup>.fromJson(
      response, (data) => Signup.fromJson(data));
    //print(sd.message);
    return sd;
  }
}
