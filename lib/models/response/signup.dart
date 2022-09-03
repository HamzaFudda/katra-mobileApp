import 'dart:convert';

class Signup {
  late final String? message;

  Signup(this.message);

  factory Signup.fromJson(Map<String, dynamic> json) {
    return Signup(json[""]);
  }

  Map toJson() =>
      {
        jsonEncode(""): jsonEncode(message)
      };
}