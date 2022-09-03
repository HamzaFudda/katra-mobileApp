import 'package:katra/repos/profile_repo.dart';

import '../../../api_manager/network_services.dart';
import '../../../api_manager/response.dart';
import '../../../models/response/profile.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProfileBloc {
  final ProfileRepo _profileRepo;

  ProfileBloc(this._profileRepo);

  logout() async {
    await _profileRepo.logout();
  }

  Future<APIResponse<Profile>> getProfile() async {
    final result = await _profileRepo.getProfile();
    return result;
  }

  Future<APIResponse<Profile>> editProfile({
    required String name,
    required String phoneNumber,
    required String weight,
    required String dateOfBirth,
    required String bloodGroup,
  }) async {
    print(name + " " + dateOfBirth);
    final result = await _profileRepo.editProfile(
      name: name,
      phoneNumber: phoneNumber,
      weight: weight,
      dateOfBirth: dateOfBirth,
      bloodGroup: bloodGroup,
    );
    return result;
  }

  changePassword({required String email}) async {
    var response = await http.post(
        Uri.parse(NetworkServices.baseURL + NetworkServices.forgetPassword),
        body: {"email": email});
    print(response.statusCode);
    return response.statusCode;
  }
}
