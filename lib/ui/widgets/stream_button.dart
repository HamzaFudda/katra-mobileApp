import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constant/color.dart';

class StreamButton extends StatefulWidget {
  String buttonText;
  final Function onPressed;
  Stream<Object> blocStream;

  StreamButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      required this.blocStream})
      : super(key: key);

  @override
  State<StreamButton> createState() => _StreamButtonState();
}

class _StreamButtonState extends State<StreamButton> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: widget.blocStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData ? widget.onPressed() : null,
          child: Text(
            widget.buttonText,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HexColor("#FFFFFF")),
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: HexColor("#FA938E"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              minimumSize: Size(300, 56)),
        );
      },
    );
  }
}
