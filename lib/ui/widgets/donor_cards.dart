import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katra/constant/assets.dart';
import 'package:katra/constant/color.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/models/response/homepage.dart';
import 'package:katra/ui/widgets/alert_box.dart';
import 'package:katra/ui/widgets/button.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/poppins_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/strings_ui.dart';
import '../../di/locator.dart';
import '../../repos/login_repo.dart';
import '../screens/login_page/login_page.dart';

class DonorCards extends StatefulWidget {
  // String name;
  // List<String> canDonateTO;
  // String bloodGroup;
  Donor donor;

  DonorCards(
      {Key? key,
      // required this.name,
      // required this.bloodGroup,
      // required this.canDonateTO,
      required this.donor})
      : super(key: key);

  @override
  _DonorCardsState createState() => _DonorCardsState();
}

class _DonorCardsState extends State<DonorCards> {
  String splitCanDonate() {
    if (widget.donor.canDonateTO!.length >= 6) {}
    return widget.donor.canDonateTO!.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Container(
        height: 168,
        width: 350,
        decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ColorConstants.borderColorWhiteContainer,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: PoppinsText(
                          text: "Name",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.grey_text_color,
                        ),
                      ),
                      PoppinsText(
                        text: widget.donor.name!,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.black_text_color,
                      ),
                      SizedBoxes.verticalTiny,
                      //SizedBoxes.verticalMicro,
                      PoppinsText(
                        text: "Can donate to",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.grey_text_color,
                      ),
                      PoppinsText(
                        text: widget.donor.canDonateTO!.join(", "),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.black_text_color,
                      ),
                      SizedBoxes.verticalTiny,
                      // SizedBoxes.verticalMicro,
                      PoppinsText(
                        text: "Distance from you",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.grey_text_color,
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: PoppinsText(
                          text: widget.donor.approxDist!,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.black_text_color,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Container(
                          height: 80,
                          width: 60,
                          child: Stack(
                            children: [
                              Container(
                                child: Image(
                                  image:
                                      AssetImage(ImageAssets.homepageBloodDrop),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBoxes.verticalTiny,
                                  SizedBoxes.verticalTiny,
                                  Center(
                                    child: InterText(
                                        text: widget.donor.bloodGroup!,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24,
                                        color: ColorConstants.whiteColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBoxes.verticalTiny,
                      SizedBoxes.verticalMicro,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: OutlineUI_Button(
                          borderColor: "#01CED3",
                          buttonText: "Show number",
                          onPressed: () {
                            if (getItLocator.get<LoginRepo>().accessToken ==
                                null) {
                              showAlertBox(
                                context: context,
                                title: StringsUI.alertBoxLoginTitle,
                                buttonText: StringsUI.alertBoxLoginButton,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                  setState(() {});
                                },
                              );
                            } else {
                              showAlertBox(
                                context: context,
                                title: widget.donor.phoneNumber,
                                buttonText: "Call",
                                onPressed: () {
                                  launch(
                                      'tel://' + (widget.donor!.phoneNumber!));
                                },
                              );
                            }
                          },
                          buttonSize: Size(116, 30),
                          // buttonColor: ColorConstants.blue_button_color_text,
                          borderRadius: 8,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
