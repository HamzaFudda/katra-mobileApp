import 'package:flutter/material.dart';
import 'package:katra/constant/assets.dart';
import 'package:katra/constant/strings_ui.dart';

class Pages {
  final String image_URL;
  final String title;
  final String description;

  Pages({
    required this.title,
    required this.description,
    required this.image_URL,
  });
}

final page_list = [
  Pages(
      title: StringsUI.onboardingPage1Heading,
      description:StringsUI.onboardingPage1Description ,
      image_URL: ImageAssets.splashScreen2),
  Pages(
      title: StringsUI.onboardingPage2Heading,
      description:StringsUI.onboardingPage2Description,
      image_URL: ImageAssets.splashScreen3),
  Pages(
      title: StringsUI.onboardingPage3Heading,
      description:StringsUI.onboardingPage3Description,
      image_URL: ImageAssets.splashScreen4),
];
