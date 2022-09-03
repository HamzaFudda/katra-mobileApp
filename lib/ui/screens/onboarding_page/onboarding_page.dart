import 'package:flutter/material.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/constant/strings_ui.dart';
import 'package:katra/models/pages.dart';
import 'package:katra/ui/screens/homepage_page/homepage_page.dart';
import 'package:katra/ui/screens/navbar_navigation_page/navbar_navigation_page.dart';
import 'package:katra/ui/screens/onboarding_page/onboarding_bloc.dart';
import 'package:katra/ui/screens/onboarding_page/widgets/page_indicators.dart';
import 'package:katra/ui/screens/onboarding_page/widgets/page_slider.dart';
import 'package:katra/ui/screens/signup_page/signup_page.dart';
import 'package:katra/ui/widgets/blue_text.dart';
import 'package:katra/ui/widgets/button.dart';

import '../../../constant/color.dart';
import '../../widgets/inter_text.dart';
import '../login_page/login_page.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //int _currentPage = 0;
  OnBoardingBloc onBoardingBloc = OnBoardingBloc();

  PageController page_controller = PageController(initialPage: 0);

  _onPageChanged(int index) {
    onBoardingBloc.pageChangeSink.add(index);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    page_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: onBoardingBloc.pageChangeStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: page_controller,
                  itemCount: page_list.length,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, position) {
                    {
                      // print(snapshot.hasData);
                      // print(snapshot.data);
                      // print("");

                      if (snapshot.hasData) {
                        position = snapshot.data!;

                        return PageSlider(index: position);
                      } else {
                        return Container();
                      }
                    }
                  },
                ),
              ),
              SizedBoxes.verticalMedium,
              Container(
                margin: const EdgeInsets.only(bottom: 35),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < page_list.length; i++)
                      if (i == snapshot.data)
                        PageIndicator(
                          is_active: true,
                        )
                      else
                        PageIndicator(
                          is_active: false,
                        )
                  ],
                ),
              ),
              SizedBoxes.verticalExtraGargangua,
              snapshot.data == (page_list.length - 1)
                  ? UI_Button(
                      buttonText: StringsUI.onboardingPageButtonDescriptionGuest,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NavBarNavigationPage(),
                          ),
                        );
                        setState(() {});
                      },
                    )
                  : UI_Button(
                      buttonText: StringsUI.onboardingPageButtonDescriptionNext,
                      onPressed: () {
                        onBoardingBloc.pageChangeSink.add(snapshot.data! + 1);
                        //setState(() {});
                      },
                    ),
              SizedBoxes.verticalGargangua,
              snapshot.data != (page_list.length - 1)
                  ? BlueText(
                      buttonText: StringsUI.skip,
                      onTap: () {
                        //onBoardingBloc.pageChangeSink.add(page_list.length - 1);
                        _onPageChanged(page_list.length - 1);
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InterText(
                          text: StringsUI.onboardingScreenAlreadyHaveAnAccount,
                          fontSize: 16,
                          color: ColorConstants.grey_text_color,
                        ),
                        BlueText(
                          buttonText: StringsUI.onboardingScreenLoginText,
                          fontSize: 16,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
              SizedBoxes.verticalGargangua,
            ],
          );
        },
      ),
    );
  }
}
