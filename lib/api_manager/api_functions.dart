import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:katra/api_manager/network_services.dart';

class apiFunctions {
  apiFunctions._();

  static Future<void> login({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    print(emailController.text);
    print(passwordController.text);

    var response = await http.post(
      //Uri.parse("https://reqres.in/api/login"),
      //Uri.parse(NetworkServices.baseURL+"api/v1/login"),
      Uri.parse(NetworkServices.baseURL+NetworkServices.login),
      body: ({
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      print("api test successful");
      print(response.body);

    } else {
      print(response.statusCode);
      print(response.body);

    }
  }

  static Future<void> register({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneNumberController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    var response = await http.post(
      //Uri.parse("https://reqres.in/api/login"),
      // Uri.parse("http://10.0.2.2:5000/api/v1/register"),
      Uri.parse(NetworkServices.baseURL+NetworkServices.signup),
      body: ({
        "fullName": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirmedPassword": confirmPasswordController.text,
        "phoneNumber": phoneNumberController.text,
      }),
    );
    if (response.statusCode == 200) {
      print("api test successful");
      print(response.body);
    } else {

      print(response.statusCode);
    }
  }

  static Future<void> forgetPssword({
    required TextEditingController emailController,
  }) async {
    var response = await http.post(
      //Uri.parse("https://reqres.in/api/login"),
      //Uri.parse("http://10.0.2.2:5000/api/v1/forgotPassword"),
      Uri.parse(NetworkServices.baseURL+NetworkServices.forgetPassword),
      body: ({
        "email": emailController.text,
      }),
    );
    if (response.statusCode == 200) {
      print("api test successful");
      print(response.body);

    } else {
      print(response.statusCode);
      print(response.body);

    }
  }
}
