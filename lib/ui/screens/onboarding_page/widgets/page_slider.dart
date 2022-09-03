import 'package:flutter/material.dart';
import 'package:katra/constant/color.dart';
import 'package:katra/constant/sized_boxes.dart';
import 'package:katra/models/pages.dart';
import 'package:katra/ui/widgets/inter_text.dart';
import '../../../widgets/poppins_text.dart';

class PageSlider extends StatefulWidget {
  final int index;

  PageSlider({Key? key, required this.index}) : super(key: key);

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBoxes.verticalGargangua,
        SizedBoxes.verticalGargangua,
        SizedBoxes.verticalGargangua,
        Container(
          height: 231,
          width: 355,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image(
              image: AssetImage(page_list[widget.index].image_URL),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        PoppinsText(
          text: page_list[widget.index].title,
          fontSize: 24,
          color: ColorConstants.black_text_color,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        InterText(
          text: page_list[widget.index].description,
          fontSize: 16,
          color: ColorConstants.grey_text_color,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
