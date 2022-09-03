import 'dart:convert';

class Homepage {
  late final List<Donor>? donorsForHomepage;

  Homepage(
    this.donorsForHomepage,
  );

  factory Homepage.fromJson(List<dynamic> json) {
    List<Donor> donorsForHomepage = <Donor>[];
    donorsForHomepage = json.map((i) => Donor.fromJson(i)).toList();

    return new Homepage(donorsForHomepage);
  }
}

class Donor {
  late final String? name;
  late final String? bloodGroup;
  late final String? approxDist;
  late final String? phoneNumber;
  late final List<String>? canDonateTO;

  Donor(
    this.name,
    this.bloodGroup,
    this.canDonateTO,
    this.approxDist,
    this.phoneNumber,
  );

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      json["name"],
      json["bloodGroup"],
      List<String>.from(
        json["canDonateTo"],
      ),
      json["approximateDistance"],
      json["phoneNumber"],
    );
  }

  Map toJson() => {
        jsonEncode("name"): jsonEncode(name),
        jsonEncode("bloodGroup"): jsonEncode(bloodGroup),
        jsonEncode("canDonateTo"): jsonEncode(canDonateTO),
        jsonEncode("approximateDistance"): jsonEncode(approxDist),
        jsonEncode("phoneNumber"): jsonEncode(phoneNumber),
      };
}
