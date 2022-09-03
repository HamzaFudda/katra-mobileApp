import 'dart:convert';

class UserLocation {
  late final String? latitude;
  late final String? longitude;

  UserLocation(this.longitude, this.latitude);

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(json["long"], json["lat"]);
  }

  Map toJson() => {
        jsonEncode("long"): jsonEncode(longitude),
        jsonEncode("lat"): jsonEncode(latitude)
      };
}
