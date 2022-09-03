import 'dart:convert';

class Profile {
  late final String? name;
  late final String? email;
  late final String? phoneNumber;
  late final DateTime? dateOfBirth;
  late final String? bloodGroup;
  late final int? weight;

  Profile(
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.bloodGroup,
    this.weight,
  );

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      json["fullName"],
      json["email"],
      json["phoneNumber"],
      json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
      json["Blood Group"],
      json["weight"] == null ? 0 :json["weight"] ,
    );
  }

  Map toJson() => {
        jsonEncode("fullName"): jsonEncode(name),
        jsonEncode("email"): jsonEncode(email),
        jsonEncode("phoneNumber"): jsonEncode(phoneNumber),
        jsonEncode("dateOfBirth"): jsonEncode(dateOfBirth?.toIso8601String()),
        jsonEncode("Blood Group"): jsonEncode(bloodGroup),
        jsonEncode("weight"): jsonEncode(weight),
      };
}
