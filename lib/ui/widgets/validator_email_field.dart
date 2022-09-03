import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidatorEmailField extends StatelessWidget {
  ValidatorEmailField(
      {Key? key,
      required this.hintText,
      required this.submit,
      required this.validatorController})
      : super(key: key);
  TextEditingController validatorController;

  bool submit;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: TextFormField(
        controller: validatorController,
        style: GoogleFonts.inter(
          textStyle: TextStyle(color: Colors.black, fontSize: 14),
        ),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: !submit ? Colors.black54 : Colors.red, fontSize: 14),
          ),
          disabledBorder: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        autovalidateMode: submit
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Please Enter Email';
          }
        },
      ),
    );
  }
}
