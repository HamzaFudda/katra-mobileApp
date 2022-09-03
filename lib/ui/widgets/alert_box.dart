import 'package:flutter/material.dart';
import 'package:katra/constant/color.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/ui/widgets/button.dart';
import 'package:katra/ui/widgets/poppins_text.dart';

import '../../constant/strings_ui.dart';

class AlertBox extends StatefulWidget {
  String title;
  String buttonText;
  final Function onPressed;

  AlertBox({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  _AlertBoxState createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          height: 150,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PoppinsText(
                text: widget.title,
                fontSize: 15,
                color: ColorConstants.black_text_color,
                fontWeight: FontWeight.w500,
              ),
              SizedBoxes.verticalBig,
              SizedBoxes.verticalMedium,
              UI_Button(
                buttonText: widget.buttonText,
                onPressed: () {
                  widget.onPressed();
                },
                buttonSize: const Size(250, 48),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Future showAlertBox({
  required context,
  required title,
  required buttonText,
  required onPressed,
}) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertBox(
      title: title,
      buttonText: buttonText,
      onPressed: () {
        onPressed();
      },
    ),
  );
}
