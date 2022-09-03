import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';

class BlueText extends StatelessWidget {
  String buttonText;
  Function onTap;

  BlueText({Key? key, required this.buttonText, required this.onTap,this.fontSize=14.0,})
      : super(key: key);
double fontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          textStyle:
              TextStyle(fontSize: fontSize, color: ColorConstants.skip_text_color,
                  fontWeight: FontWeight.w500,
                  ),
        ),
      ),
    );
  }
}
