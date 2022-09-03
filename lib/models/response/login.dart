import 'dart:convert';

import '../../constant/prefrence_key.dart';
import '../../db_manager/local_storage_service.dart';

class Login {
  late final String? accessToken;
  late final String? refreshToken;


  Login(this.accessToken, this.refreshToken);

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(json["AccessToken"], json["RefreshToken"]);
  }

  Map toJson() =>
      {
        jsonEncode("AccessToken"): jsonEncode(accessToken),
        jsonEncode("RefreshToken"): jsonEncode(refreshToken)
      };



}
// await SharedPreferenceUtil.saveData(
// key: PreferenceKeys.USER, data: result.data!.toJson());

// Login.fromJson(SharedPreferenceUtil.getData(key: PreferenceKeys.USER))

