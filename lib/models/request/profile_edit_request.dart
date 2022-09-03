import 'dart:convert';

class ProfileEditRequest {
  String? fullName;
  String? phoneNumber;
  String? weight;
  DateTime? dateOfBirth;
  String? bloodGroup;

  ProfileEditRequest(
    this.fullName,
    this.phoneNumber,
    this.weight,
    this.dateOfBirth,
    this.bloodGroup,
  );

  // Map toJson() => {
  //       jsonEncode("fullName"): jsonEncode(fullName),
  //       jsonEncode("phoneNumber"): jsonEncode(phoneNumber),
  //       jsonEncode("weight"): jsonEncode(weight),
  //       jsonEncode("dateOfBirth"): jsonEncode(dateOfBirth?.toIso8601String()),
  //       jsonEncode("BloodGroup"): jsonEncode(bloodGroup),
  //     };

  Map<String, dynamic> toJson() => {
        "fullName": this.fullName,
        "phoneNumber": this.phoneNumber,
        "weight": this.weight,
        "dateOfBirth": this.dateOfBirth?.toIso8601String(),
        "BloodGroup": this.bloodGroup,
      };
}
