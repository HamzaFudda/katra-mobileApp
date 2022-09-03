import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../constant/color.dart';

class DateOfBirthButton extends StatefulWidget {
  final String textFieldHint;
  final String? errorText;
  final TextInputType keyboardType;

  // final ValueChanged<String>? onChanged;
  final VoidCallback? obscureTextTap;
  final String? initialValue;
  final bool? enabled;
  final Function(DateTime) onPressedUpdate;
  DateTime? editDate;
  DateTime selectedDate;

  DateOfBirthButton(
      {Key? key,
      required this.textFieldHint,
      required this.errorText,
      required this.keyboardType,
      //required this.onChanged,
      this.obscureTextTap,
      this.initialValue,
      this.enabled,
      required this.selectedDate,
      required this.onPressedUpdate,
      this.editDate})
      : super(key: key);

  @override
  _DateOfBirthButtonState createState() => _DateOfBirthButtonState();
}

class _DateOfBirthButtonState extends State<DateOfBirthButton> {
  DateTime? selected;
  TextEditingController _date = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.editDate != null) {
      _date.text = DateFormat('dd-MMM-yyyy').format(widget.editDate!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      //style: AppStyles.loginRegisterTextBoxStyle(),
      //onChanged: widget.onChanged,
      controller: _date,
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      showCursor: false,
      onTap: () async {
        await _selectDate(context);
        (selected != null)
            ? _date.text = DateFormat('dd-MMM-yyyy').format(widget.selectedDate)
            //clear controller if no date is selected
            : _date.clear();
        setState(() {});
      },
      readOnly: true,
      style: GoogleFonts.inter(
        textStyle:
            TextStyle(color: ColorConstants.textfieldColor, fontSize: 14),
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: widget.textFieldHint,
        errorText: widget.errorText,
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 14),
        ),
        disabledBorder: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(1940),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != widget.selectedDate) {
      setState(() {
        widget.selectedDate = selected!;
      });
      //use of callback
      widget.onPressedUpdate(widget.selectedDate);
    }
    //print(selected);
  }
}
