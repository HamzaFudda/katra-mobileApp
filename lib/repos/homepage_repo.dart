import 'package:http/http.dart' as http;

import '../api_manager/client.dart';
import '../api_manager/network_services.dart';
import '../api_manager/response.dart';
import '../di/locator.dart';
import '../models/response/homepage.dart';
import 'login_repo.dart';

class HomepageRepo {
  final Client serviceClient;

  HomepageRepo(this.serviceClient);

  Future<APIResponse<Homepage>> getDonors() async {
    final response;
    if (getItLocator.get<LoginRepo>().accessToken != null) {
      print("first");
      response = await serviceClient.getNetworkRequest(
        Uri.parse(NetworkServices.baseURL + NetworkServices.getDonors),
        {
          'auth-token': getItLocator.get<LoginRepo>().accessToken.toString(),
        },
      );
    } else {
      response = await serviceClient.getNetworkRequest(
        Uri.parse(NetworkServices.baseURL + NetworkServices.getDonors),
      );
    }
    print(response.toString());
    final sd = APIResponse<Homepage>.fromJson(
      response,
      (data) {
        return Homepage.fromJson(data);
      },
    );
    print(sd.data?.donorsForHomepage?[0].approxDist);
    return sd;
  }
}
