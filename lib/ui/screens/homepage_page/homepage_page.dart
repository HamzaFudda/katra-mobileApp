import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katra/constant/color.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/constant/strings_ui.dart';
import 'package:katra/models/response/homepage.dart';
import 'package:katra/ui/screens/homepage_page/homepage_bloc.dart';
import 'package:katra/ui/screens/login_page/login_page.dart';
import 'package:katra/ui/widgets/alert_box.dart';
import 'package:katra/ui/widgets/button.dart';
import 'package:katra/ui/widgets/donor_cards.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/poppins_text.dart';
import 'package:async/async.dart';

import '../../../api_manager/response.dart';
import '../../../constant/assets.dart';
import '../../../constant/blood_groups.dart';
import '../../../di/locator.dart';
import '../../../helper/exitFunction.dart';
import '../../../repos/login_repo.dart';
import '../../widgets/blood_type_cards.dart';

class HomepagePage extends StatefulWidget {
  const HomepagePage({Key? key}) : super(key: key);

  @override
  _HomepagePageState createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage> {
  HomepageBloc _homepageBloc = getItLocator.get<HomepageBloc>();
  late final response;
  Homepage? _homepage;
  bool isCalled = false;
  bool isFetching = false;
  late final Future listFuture = getDonors();
  late Future getData;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getData = getDonors();
  }

  Future<APIResponse<Homepage>> getDonors() async {
    // APIResponse<Homepage> response = await _homepageBloc.getDonors();
    // await _homepageBloc.getDonors();
    await _homepageBloc.getDonorStatus();
    isFetching = true;
    setState(() {});
    return await _homepageBloc.getDonors();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
      child: Scaffold(
        body: SafeArea(
          child: (isFetching == false)
              ? loader()
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 10, 8),
                              child: Image(
                                image: AssetImage(ImageAssets.homepageTopPart),
                              ),
                            ),
                          ),
                          if (getItLocator.get<LoginRepo>().accessToken ==
                              null) ...{
                            UI_Button(
                              buttonText: StringsUI.homepageDonorButton,
                              onPressed: () {
                                showAlertBox(
                                  context: context,
                                  title: StringsUI.alertBoxLoginTitle2,
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
                              },
                            ),
                          } else if (_homepageBloc.donorStatus != null) ...{
                            if (_homepageBloc.donorStatus! &&
                                _homepageBloc.doNotChange) ...{
                              UI_Button(
                                buttonText: StringsUI.homepageDonorButtonOff,
                                onPressed: () async {
                                  await _homepageBloc.toggleStatus();
                                  setState(() {});
                                },
                                buttonColor: "#FFC4C1",
                                textColor: "#45484F",
                              )
                            } else ...{
                              UI_Button(
                                  buttonText: StringsUI.homepageDonorButton,
                                  onPressed: () async {
                                    await _homepageBloc.toggleStatus();
                                    setState(() {});
                                  })
                            }
                          } else ...{
                            // UI_Button(
                            //   buttonText: StringsUI.homepageDonorButton,
                            //   onPressed: () {
                            //     showAlertBox(
                            //       context: context,
                            //       title: StringsUI.alertBoxLoginTitle,
                            //       buttonText: StringsUI.alertBoxLoginButton,
                            //       onPressed: () {
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (context) => LoginPage(),
                            //           ),
                            //         );
                            //         setState(() {});
                            //       },
                            //     );
                            //   },
                            // ),
                          },
                        ],
                      ),
                      SizedBoxes.verticalExtraGargangua,
                      SizedBoxes.verticalTiny,
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: PoppinsText(
                                text: StringsUI.homepageSelectBloodGroups,
                                fontSize: 20,
                                textAlign: TextAlign.start,
                                color: ColorConstants.black_text_color),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Container(
                              height: 180,
                              width: 360,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: bloodGroupList.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (context, position) {
                                    return Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: BloodTypeCards(
                                        index: position,
                                        onPressed: () {
                                          _homepageBloc.sortList(
                                            bloodGroup:
                                                bloodGroupList[position],
                                          );
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          // SizedBoxes.verticalTiny,
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: InkWell(
                              onTap: () {
                                _homepageBloc.resetList();
                                setState(() {});
                              },
                              child: PoppinsText(
                                  text: "Clear search",
                                  fontSize: 14,
                                  color: ColorConstants.grey_text_color),
                            ),
                          ),
                        ],
                      ),
                      SizedBoxes.verticalBig,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: PoppinsText(
                              text: StringsUI.donors,
                              fontSize: 20,
                              color: ColorConstants.black_text_color,
                            ),
                          ),
                          FutureBuilder(
                            future: getData,
                            //future: _homepageBloc.getDonors(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (_homepageBloc.changingDonorlist != null &&
                                    _homepageBloc.changingDonorlist!.length > 0)
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    // itemCount: _homepage?.donorsForHomepage?.length,
                                    itemCount:
                                        _homepageBloc.changingDonorlist!.length,
                                    itemBuilder: (context, position) {
                                      return DonorCards(
                                        donor: _homepageBloc
                                            .changingDonorlist![position],
                                        //donor: _homepage!.donorsForHomepage![position],
                                      );
                                    },
                                  );
                                else
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 0, 50),
                                    child: Center(
                                      child: PoppinsText(
                                        text:
                                            "Sorry, there aren't any compatible donors available for this blood type at the moment.",
                                        fontSize: 16,
                                        color: ColorConstants.grey_text_color,
                                      ),
                                    ),
                                  );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 0, 50),
                                    child: PoppinsText(
                                      text:
                                          "Sorry, there aren't any donors available.",
                                      fontSize: 16,
                                      color: ColorConstants.black_text_color,
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 50, 0, 50),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class loader extends StatefulWidget {
  const loader({Key? key}) : super(key: key);

  @override
  _loaderState createState() => _loaderState();
}

class _loaderState extends State<loader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
