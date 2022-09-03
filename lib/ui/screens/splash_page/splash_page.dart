import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:katra/constant/assets.dart';
import 'package:katra/ui/screens/navbar_navigation_page/navbar_navigation_page.dart';
import 'package:katra/ui/screens/onboarding_page/onboarding_page.dart';

import '../../../constant/color.dart';
import '../../../di/locator.dart';
import '../../../repos/login_repo.dart';
import '../login_page/login_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  postLocation() async {
    if (getItLocator.get<LoginRepo>().accessToken != null) {
      await getItLocator.get<LoginBloc>().locationService();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    postLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: AnimatedSplashScreen(
            splash: ImageAssets.KatraLogo,
            nextScreen: (getItLocator.get<LoginRepo>().accessToken != null)
                ? NavBarNavigationPage()
                : OnboardingPage(),
            //nextScreen: NavBarNavigationPage(),
            splashTransition: SplashTransition.fadeTransition,
            //pageTransitionType: PageTransitionType.scale,
            duration: 1500,
            backgroundColor: ColorConstants.main_page_background_color,
          ),
        ),
      ),
    );
  }
}
