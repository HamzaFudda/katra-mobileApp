import 'package:flutter/material.dart';

import '../../constant/blood_groups.dart';
import '../../constant/color.dart';
import 'inter_text.dart';

class BloodTypeCards extends StatefulWidget {
  int index;
  Function onPressed;

  BloodTypeCards({
    Key? key,
    required this.index,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<BloodTypeCards> createState() => _BloodTypeCardsState();
}

class _BloodTypeCardsState extends State<BloodTypeCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: ColorConstants.bloodTypeCards,
      width: 50,
      height: 36,
      child: InkWell(
        child: Card(
          color: ColorConstants.bloodTypeCards,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: InterText(
              text: bloodGroupList[widget.index],
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ColorConstants.black_text_color,
            ),
          ),
        ),
        onTap: () {
          widget.onPressed();
        },
      ),
    );
  }
}
