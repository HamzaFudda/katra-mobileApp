//URLs and endpoints
//base urls +paths +endpoints
class NetworkServices {
  //static const String baseURL = "http://10.0.2.2:5000/";

  static const String baseURL =
      "http://katra-lb-314246082.us-east-1.elb.amazonaws.com:5000/";

  //paths
  static const String _app = "api/v1/";

  //endpoints
  static String login = _app + "login";
  static String logout = _app + "logout";
  static String signup = _app + "register";
  static String forgetPassword = _app + "forgotPassword";
  static String getDonors = _app + "getDonors";
  static String userLocation = _app + "insertUserLocation";
  static String getProfile = _app + "getProfile";
  static String updateProfile = _app + "updateProfile";
  static String getDonorStatus = _app + "getDonorStatus";
  static String activateStatus = _app + "updateDonorStatus";

}
