import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterText extends StatelessWidget {
  InterText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.w500,
    required this.color,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
