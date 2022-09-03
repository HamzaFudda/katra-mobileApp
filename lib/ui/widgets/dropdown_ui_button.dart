import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katra/ui/widgets/poppins_text.dart';

import '../../constant/blood_groups.dart';
import '../../constant/color.dart';
import '../../constant/strings_ui.dart';

class DropdownUIButton extends StatefulWidget {
  String value;
  final ValueChanged<String>? onUpdate;

  DropdownUIButton({
    Key? key,
    this.value = "Select Blood Group",
    required this.onUpdate,
  }) : super(key: key);

  @override
  _DropdownUIButtonState createState() => _DropdownUIButtonState();
}

class _DropdownUIButtonState extends State<DropdownUIButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: StringsUI.bloodGroup,
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 14),
        ),

        disabledBorder: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: widget.value.toString(),
      items: bloodGroupListDropDown.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: PoppinsText(text: items, fontSize:14, color: ColorConstants.grey_text_color,),
        );
      }).toList(),
      onChanged: (value) {
        widget.value = value.toString();
        widget.onUpdate;
        setState(() {});
      },
    );
  }
}
