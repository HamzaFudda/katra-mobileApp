import 'package:katra/api_manager/client.dart';
import 'package:http/http.dart' as http;
import 'package:katra/models/response/profile.dart';

import '../api_manager/network_services.dart';
import '../api_manager/response.dart';
import '../di/locator.dart';
import '../models/response/forgetpassword.dart';
import 'login_repo.dart';
import 'dart:convert';

class ProfileRepo {
  final Client serviceClient;

  ProfileRepo(this.serviceClient);

  Future<void> logout() async {
    print(getItLocator
        .get<LoginRepo>()
        .accessToken!
        .toString());
    //final result = response;
    var response = await http.get(
      Uri.parse(NetworkServices.baseURL + NetworkServices.logout),
      headers: {
        'auth-token': getItLocator
            .get<LoginRepo>()
            .accessToken!
            .toString(),
      },
    );
    print(response.body);
  }

  Future<APIResponse<Profile>> getProfile() async {
    final response = await serviceClient.getNetworkRequest(
      Uri.parse(NetworkServices.baseURL + NetworkServices.getProfile),
      {
        'auth-token': getItLocator
            .get<LoginRepo>()
            .accessToken!
            .toString(),
      },
    );
    print(response.toString());
    final sd = APIResponse<Profile>.fromJson(
      response,
          (data) {
        return Profile.fromJson(data);
      },
    );
    print(sd.data!.name!);
    return sd;
  }

  Future<APIResponse<Profile>> editProfile({
    required String name,
    required String phoneNumber,
    required String weight,
    required String dateOfBirth,
    required String bloodGroup,
  }) async {
    final response = await serviceClient.postNetworkRequest(
      Uri.parse(NetworkServices.baseURL + NetworkServices.updateProfile),
      ({
        "fullName": name,
        "phoneNumber": phoneNumber,
        "weight": weight,
        "dateOfBirth": dateOfBirth,
        "bloodGroup": bloodGroup,
      }),
      {
        'auth-token': getItLocator
            .get<LoginRepo>()
            .accessToken
            .toString(),
      },
    );

    //final result = response;
    final sd = APIResponse<Profile>.fromJson(
        response, (data) => Profile.fromJson(data));
    print(sd.message);
    return sd;
  }

  Future<APIResponse<Profile>> editProfile2() async {
    final response = await serviceClient.postNetworkRequest(
      Uri.parse(NetworkServices.baseURL + NetworkServices.updateProfile),

      {

        "fullName": "Tabish",
        "phoneNumber": "+92-321-1487152",
        "weight": "80",
        "dateOfBirth": "2000-01-03",
        "bloodGroup": "B+",
      },
      {
        'auth-token': getItLocator
            .get<LoginRepo>()
            .accessToken
            .toString(),
      },
    );

    //final result = response;
    final sd = APIResponse<Profile>.fromJson(
        response, (data) => Profile.fromJson(data));
    print(sd.message);
    return sd;
  }


 

}