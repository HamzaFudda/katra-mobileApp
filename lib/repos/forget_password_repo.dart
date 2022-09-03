import 'package:katra/api_manager/client.dart';
import 'package:http/http.dart' as http;
import 'package:katra/api_manager/network_services.dart';
import 'package:katra/ui/widgets/password_field.dart';

import '../api_manager/response.dart';
import '../models/response/forgetpassword.dart';

class ForgetPasswordRepo {
  final Client serviceClient;

  ForgetPasswordRepo(this.serviceClient);

  static Future<void> forgetPssword({
    required String email,
  }) async {
    var response = await http.post(
      //Uri.parse("https://reqres.in/api/login"),
      Uri.parse(NetworkServices.baseURL+NetworkServices.forgetPassword),
      body: ({
        "email": email,
      }),
    );
    if (response.statusCode == 200) {
      print("api test successful");
    } else {
      print(response.statusCode);
    }
  }

  Future<APIResponse<ForgetPassword>> postForget({
    required String email,

  }) async {
    final response = await serviceClient.postNetworkRequest(
      Uri.parse(NetworkServices.baseURL + NetworkServices.forgetPassword),
      ({
        "email": email,

      }),
    );

    //final result = jsonDecode(response.body);
    final sd = APIResponse<ForgetPassword>.fromJson(

        response,
            (data) =>
                ForgetPassword.fromJson(data));
    // print(sd.message);
    // print(sd.data);


    return sd;
  }
}



