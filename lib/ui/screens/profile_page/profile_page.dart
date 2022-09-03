import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/di/locator.dart';
import 'package:katra/models/response/profile.dart';
import 'package:katra/ui/screens/profile_page/profile_bloc.dart';
import 'package:katra/ui/widgets/button.dart';
import 'package:katra/ui/widgets/date_of_birth_button.dart';
import 'package:katra/ui/widgets/dropdown_ui_button.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/poppins_text.dart';
import 'package:katra/ui/widgets/single_line_text_form_field.dart';

import '../../../api_manager/response.dart';
import '../../../constant/assets.dart';
import '../../../constant/color.dart';
import '../../../constant/prefrence_key.dart';
import '../../../constant/strings_ui.dart';
import '../../../db_manager/local_storage_service.dart';
import '../../../helper/exitFunction.dart';
import '../../../repos/login_repo.dart';
import '../login_page/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _profileBloc = getItLocator.get<ProfileBloc>();
  APIResponse<Profile>? response;
  bool isLoading = true;
  TextEditingController _name = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  DateTime? _dateOfBirth;
  TextEditingController _bloodGroup = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _email = TextEditingController();

  getprofile() async {
    response = await _profileBloc.getProfile();
    isLoading = false;
    if (response!.data!.name != null) _name.text = response!.data!.name!;
    if (response!.data!.email != null) _email.text = response!.data!.email!;
    if (response!.data!.phoneNumber != null)
      _phoneNumber.text = response!.data!.phoneNumber!;
    if (response!.data!.dateOfBirth != null) {
      _dateOfBirth = response!.data!.dateOfBirth!;
      print(_dateOfBirth);
    }
    if (response!.data!.bloodGroup != null)
      _bloodGroup.text = response!.data!.bloodGroup!;
    if (response!.data!.weight != null)
      _weight.text = response!.data!.weight!.toString();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getprofile();
    //setText();
    super.initState();
  }

  setText() {
    if (response!.data!.name == null) _name.text = response!.data!.name!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text(
            StringsUI.profileSettings,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstants.app_bar_color,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: (getItLocator.get<LoginRepo>().accessToken != null)
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      (isLoading)
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 200, 0, 50),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBoxes.verticalExtraGargangua,
                                SizedBoxes.verticalTiny,
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: InterText(
                                    text: StringsUI.name,
                                    fontSize: 14,
                                    color: ColorConstants.grey_text_color,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 18),
                                  child: SingleLineTextFormField(
                                    initialValue: response!.data!.name ?? null,
                                    textFieldHint: "Amir Hamza",
                                    errorText: null,
                                    keyboardType: TextInputType.name,
                                    isPassword: false,
                                    onChanged: (value) {
                                      _name.text = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: InterText(
                                    text: StringsUI.email,
                                    fontSize: 14,
                                    color: ColorConstants.grey_text_color,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 18),
                                  child: SingleLineTextFormField(
                                    textFieldHint: "inters@cc.com",
                                    initialValue: response!.data!.email ?? null,
                                    errorText: null,
                                    readOnly: true,
                                    keyboardType: TextInputType.emailAddress,
                                    isPassword: false,
                                    onChanged: null,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: InterText(
                                    text: StringsUI.phone,
                                    fontSize: 14,
                                    color: ColorConstants.grey_text_color,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 18),
                                  child: SingleLineTextFormField(
                                    textFieldHint: "+92-377-3827651",
                                    initialValue:
                                        response!.data!.phoneNumber ?? null,
                                    errorText: null,
                                    keyboardType: TextInputType.phone,
                                    isPassword: false,
                                    onChanged: (value) {
                                      _phoneNumber.text = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      InterText(
                                        text: StringsUI.theFieldsBelow,
                                        fontSize: 12,
                                        color: ColorConstants
                                            .super_black_text_color,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBoxes.verticalTiny,
                                SizedBoxes.verticalTiny,
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: InterText(
                                    text: StringsUI.dateOfBirth,
                                    fontSize: 14,
                                    color: ColorConstants.grey_text_color,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 18),
                                  child: DateOfBirthButton(
                                    textFieldHint: "Date Of Birth",
                                    errorText: null,
                                    keyboardType: TextInputType.emailAddress,
                                    onPressedUpdate: (Date) {
                                      _dateOfBirth = Date;
                                      print(_dateOfBirth);
                                    },
                                    selectedDate: DateTime.now()
                                        .subtract(const Duration(days: 10000)),
                                    editDate:
                                        response!.data!.dateOfBirth ?? null,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: InterText(
                                    text: StringsUI.bloodGroup,
                                    fontSize: 14,
                                    color: ColorConstants.grey_text_color,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 18),
                                  child: DropdownUIButton(
                                      onUpdate: (value) {
                                        _bloodGroup.text = value;
                                      },
                                      value: response!.data!.bloodGroup ??
                                          "Select Blood Group"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: InterText(
                                    text: StringsUI.weight,
                                    fontSize: 14,
                                    color: ColorConstants.grey_text_color,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 18),
                                  child: SingleLineTextFormField(
                                    textFieldHint: StringsUI.weight,
                                    errorText: null,
                                    initialValue: (response!.data!.weight == 0)
                                        ? null
                                        : response!.data!.weight.toString(),
                                    keyboardType: TextInputType.number,
                                    isPassword: false,
                                    onChanged: (value) {
                                      _weight.text = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                      Column(
                        children: [
                          SizedBoxes.verticalExtraGargangua,
                          SizedBoxes.verticalTiny,
                          SizedBoxes.verticalBig,
                          UI_Button(
                            buttonText: StringsUI.edit,
                            onPressed: () {
                              String? name;
                              String? phoneNumber;
                              String? weight;
                              String? dateOfBirth;
                              String? bloodGroup;
                              if (_name.text == "") {
                                name = "";
                              } else {
                                name = _name.text;
                              }
                              if (_phoneNumber.text == "") {
                                phoneNumber = "";
                              } else {
                                phoneNumber = _phoneNumber.text;
                              }
                              if (_weight.text == "0" || _weight.text == "") {
                                weight = "";
                              } else {
                                weight = _weight.text;
                              }
                              if (_dateOfBirth == null) {
                                dateOfBirth = "";
                              } else {
                                dateOfBirth = DateFormat('yyyy-MM-dd')
                                    .format(_dateOfBirth!);
                              }
                              if (_bloodGroup.text == "Select Blood Group") {
                                bloodGroup = "";
                              } else {
                                bloodGroup = _bloodGroup.text;
                              }

                              print(weight);

                              _profileBloc.editProfile(
                                name: name,
                                phoneNumber: phoneNumber,
                                weight: weight,
                                dateOfBirth: dateOfBirth,
                                bloodGroup: bloodGroup,
                              );
                              //_profileBloc.editProfile2();
                            },
                          ),
                          //SizedBoxes.verticalExtraGargangua,
                          SizedBoxes.verticalBig,
                          SizedBoxes.verticalTiny,
                          UI_Button(
                            buttonText: StringsUI.changePassword,
                            onPressed: () async {
                              int response = await _profileBloc.changePassword(
                                  email: _email.text);
                              if (response == 200) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Link has been sent to your email"),
                                    duration: Duration(milliseconds: 1000),
                                  ),
                                );
                              }
                            },
                            buttonColor: ColorConstants.blue_button_color_text,
                          ),
                          SizedBoxes.verticalExtraGargangua,
                          SizedBoxes.verticalExtraGargangua,
                          SizedBoxes.verticalExtraGargangua,
                          //  SizedBoxes.verticalExtraGargangua,
                          SizedBoxes.verticalTiny,
                          SizedBoxes.verticalBig,
                          InkWell(
                            onTap: () async {
                              bool logout =
                                  await showLogoutPopup(context: context);
                              if (logout) {
                                await _profileBloc.logout();
                                await SharedPreferenceUtil.clearAccess();
                                await SharedPreferenceUtil.emptyAllData();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              }
                            },
                            child: InterText(
                              text: StringsUI.logout,
                              fontSize: 16,
                              color: ColorConstants.button_color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBoxes.verticalExtraGargangua,
                        ],
                      ),
                    ],
                  ),
                )
              : loginPromptor(),
        ),
      ),
      onWillPop: () async {
        /* Do something here if you want */

        // if (getItLocator.get<LoginRepo>().accessToken == null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => LoginPage(),
        //     ),
        //   );
        //   setState(() {});
        //   return false;
        // }
        bool exit = await showExitPopup(context: context);
        if (exit) {
          SystemNavigator.pop();
        }
        return false;
      },
    );
  }
}

class loginPromptor extends StatefulWidget {
  const loginPromptor({Key? key}) : super(key: key);

  @override
  _loginPromptorState createState() => _loginPromptorState();
}

class _loginPromptorState extends State<loginPromptor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBoxes.verticalExtraGargangua,
          // SizedBoxes.verticalExtraGargangua,
          PoppinsText(
            text: "Oops! Login/Sign\nup to access this\nsection.",
            fontSize: 30,
            color: ColorConstants.super_black_text_color,
            fontWeight: FontWeight.w400,
          ),
          SizedBoxes.verticalMedium,
          UI_Button(
              buttonText: "Login/Sign up",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                setState(() {});
              })
        ],
      ),
    );
  }
}
