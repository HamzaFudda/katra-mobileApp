import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katra/constant/color.dart';
import 'package:katra/ui/widgets/button.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import 'package:katra/ui/widgets/poppins_text.dart';

Future<bool> showExitPopup({required context}) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: InterText(
              text: "Exit app",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstants.super_black_text_color),
          content: InterText(
              text: 'Do you want to exit?',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorConstants.grey_text_color),
          actions: [
            UI_Button(
              buttonText: 'No',
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              buttonSize: Size(80, 10),
              borderRadius: 4,
            ),
            UI_Button(
              buttonText: 'Yes',
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              buttonSize: Size(80, 20),
              borderRadius: 4,
            ),
          ],
        ),
      ) ??
      false;
}

Future<bool> showLogoutPopup({required context}) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: InterText(
              text: "Log out",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstants.super_black_text_color),
          content: InterText(
              text: 'Do you want to log out?',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorConstants.grey_text_color),
          actions: [
            UI_Button(
              buttonText: 'No',
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              buttonSize: Size(80, 10),
              borderRadius: 4,
            ),
            UI_Button(
              buttonText: 'Yes',
              onPressed: () {

                Navigator.of(context).pop(true);

                },
              buttonSize: Size(80, 20),
              borderRadius: 4,
            ),
          ],
        ),
      ) ??
      false;
}
