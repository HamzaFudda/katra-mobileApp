import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/prefrence_key.dart';
import '../di/locator.dart';
import '../repos/login_repo.dart';

class SharedPreferenceUtil {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static saveData<T>({required String key, required Map data}) async {
    // print(data);
    await _preferences!.setString(key, data.toString());
  }

  static T? getData<T>({required String key}) {
    T? object;
    // print(_preferences!.get(key));
    if (_preferences!.containsKey(key) && _preferences!.get(key) != null) {
      object = json.decode(_preferences!.getString(key)!);
    }
    return object;
  }

  static Future<void> emptyAllData() async {
    await _preferences!.clear();
  }

  static Future<void> clearAccess() async {
    await _preferences!.remove(PreferenceKeys.loginKey);
    getItLocator.get<LoginRepo>().accessToken=null;
  }

  SharedPreferences getSharedPreferences() {
    return _preferences!;
  }
}
