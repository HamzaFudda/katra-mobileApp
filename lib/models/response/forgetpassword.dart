import 'dart:convert';

class ForgetPassword {
  late final String? message;

  ForgetPassword(this.message);

  factory ForgetPassword.fromJson(Map<String, dynamic> json) {
    return ForgetPassword(json["message"]);
  }

  Map toJson() =>
      {
        jsonEncode("message"): jsonEncode(message)
      };
}