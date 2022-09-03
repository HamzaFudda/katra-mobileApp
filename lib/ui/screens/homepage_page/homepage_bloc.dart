import 'package:katra/models/response/homepage.dart';

import '../../../api_manager/network_services.dart';
import '../../../api_manager/response.dart';
import '../../../di/locator.dart';
import '../../../repos/homepage_repo.dart';
import 'package:http/http.dart' as http;

import '../../../repos/login_repo.dart';

class HomepageBloc {
  final HomepageRepo _donorsHomepageRepo;

  //behaviour subject list error, data
  //has data
  List<Donor>? donorlist;
  List<Donor>? changingDonorlist;
  bool? donorStatus;
  bool doNotChange = false;

  HomepageBloc(this._donorsHomepageRepo);

  Future<APIResponse<Homepage>> getDonors() async {
    final result = await _donorsHomepageRepo.getDonors();
    if (result != null) {
      Homepage? _homepage = await result.data;
      if (_homepage != null) {
        donorlist = _homepage!.donorsForHomepage!;
        changingDonorlist = _homepage!.donorsForHomepage!;
      }
    } else {
      donorlist = [];
      changingDonorlist = [];
    }
    return result;
  }

  sortList({required bloodGroup}) {
    changingDonorlist = donorlist!.where((element) {
      var bloodGroups = element.canDonateTO;
      //if (bloodGroup.length == 3)
      return (bloodGroups!.contains(bloodGroup));
      // else
      //   return (bloodGroups!.contains(bloodGroup));
    }).toList();
  }

  resetList() {
    changingDonorlist = donorlist;
  }

  Future getDonorStatus() async {
    var response = await http.get(
        Uri.parse(NetworkServices.baseURL + NetworkServices.getDonorStatus),
        headers: {
          'auth-token': getItLocator.get<LoginRepo>().accessToken.toString(),
        });

    if (response.statusCode == 200) {
      if (response.body.contains("true"))
        donorStatus = true;
      else
        donorStatus = false;
    }
    print(response.body.contains("false"));
    print(response.body);
  }

  Future toggleStatus() async {
    print("toggle status " + (!donorStatus!).toString());
    var response = await http.post(
        Uri.parse(NetworkServices.baseURL + NetworkServices.activateStatus),
        body: {
          "isDonor": (!donorStatus!).toString()
        },
        headers: {
          'auth-token': getItLocator.get<LoginRepo>().accessToken.toString(),
        });
    if (!response.body.contains("Oops!")) {
      donorStatus = !donorStatus!;
      doNotChange=!doNotChange;
    }
    print(response.body);
  }
}
