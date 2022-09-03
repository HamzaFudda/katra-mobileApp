
import 'package:flutter/material.dart';
import 'package:katra/constant/color.dart';

class PageIndicator extends StatelessWidget {
  bool is_active;
  PageIndicator({Key? key,required this.is_active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: is_active ? 12 : 8,
      width: is_active ? 12 : 8,
      decoration: BoxDecoration(
        color: is_active ? ColorConstants.indicatorPrimaryColor : ColorConstants.indicatorSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
