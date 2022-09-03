import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:katra/constant/color.dart';

class UI_Button extends StatefulWidget {
  UI_Button({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.borderRadius = 16.0,
    this.buttonSize = const Size(300, 56),
    this.buttonColor = "#FA938E",
    this.textColor = "#FFFFFF",
  }) : super(key: key);

  //w 220 h 44 HexColor("#FA938E")
  String buttonColor;
  double borderRadius;
  Size buttonSize;
  String buttonText;
  String textColor;
  final Function onPressed;

  @override
  State<UI_Button> createState() => _UI_ButtonState();
}

class _UI_ButtonState extends State<UI_Button> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      child: Text(
        widget.buttonText,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor(widget.textColor)),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: HexColor(widget.buttonColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius),
          ),
        ),
        minimumSize: widget.buttonSize,
      ),
    );
  }
}

class OutlineUI_Button extends StatefulWidget {
  OutlineUI_Button({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.borderRadius = 16.0,
    this.buttonSize = const Size(300, 56),
    this.buttonColor = "#FFFFFF",
    this.textColor = "#888888",
    this.borderColor =  "#FA938E",
  }) : super(key: key);

  //w 220 h 44 HexColor("#FA938E")
  String buttonColor;
  double borderRadius;
  Size buttonSize;
  String buttonText;
  final Function onPressed;
  String textColor;
   String borderColor;
  @override
  State<OutlineUI_Button> createState() => _OutlineUI_ButtonState();
}

class _OutlineUI_ButtonState extends State<OutlineUI_Button> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      child: Text(
        widget.buttonText,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor(widget.textColor)),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: HexColor(widget.buttonColor),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: HexColor(widget.borderColor)),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius),
          ),
        ),
        minimumSize: widget.buttonSize,
      ),
    );
  }
}
