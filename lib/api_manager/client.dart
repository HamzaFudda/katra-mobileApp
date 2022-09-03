import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helper/my_connectivity.dart';

class Client {
  final _client = http.Client();

  Future<dynamic> getNetworkRequest(Uri uri,
      [Map<String, String>? header]) async {
    if (MyConnectivity.isOnline) {
      var response = await _client.get(uri, headers: header);
      return jsonDecode(response.body);
    } else {
      return jsonDecode('{"message":"No internet connectivity.", "status":0}');
    }
  }

  Future<dynamic> postNetworkRequest(Uri uri, Object? body,
      [Map<String, String>? header]) async {
    if (MyConnectivity.isOnline) {
      var response = await _client.post(uri, headers: header, body: body);
      return jsonDecode(response.body);
    } else {
      return jsonDecode(
          '{"message":"No internet connectivity.", "status":0, "city":"New York"}');
    }
  }


  // Future<http.Response> postNetworkRequest(Uri uri, Object? body,
  //     [Map<String, String>? header]) async {
  //
  //     var response = await _client.post(uri, headers: header, body: body);
  //     return response;
  //
  // }

}
