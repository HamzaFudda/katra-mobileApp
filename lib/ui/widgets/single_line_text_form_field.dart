import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katra/constant/color.dart';

class SingleLineTextFormField extends StatefulWidget {
  final String textFieldHint;
  final String? errorText;
  bool isPassword;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? obscureTextTap;
  final String? initialValue;
  final bool? enabled;
  bool eyeButton;
  bool readOnly;
  SingleLineTextFormField(
      {Key? key,
      required this.textFieldHint,
      required this.errorText,
      required this.keyboardType,
      required this.isPassword,
      required this.onChanged,
      this.obscureTextTap,
      this.initialValue,
      this.enabled,
        this.readOnly=false,
      this.eyeButton = false})
      : super(key: key);

  @override
  _SingleLineTextFormField createState() => _SingleLineTextFormField();
}

class _SingleLineTextFormField extends State<SingleLineTextFormField> {
  bool toggle = true;

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      obscureText: widget.isPassword,
      keyboardType: widget.keyboardType,
      //style: AppStyles.loginRegisterTextBoxStyle(),
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      initialValue: widget.initialValue,

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
        suffixIcon: widget.eyeButton
            ? IconButton(
                icon: Icon(
                  toggle ? Icons.visibility : Icons.visibility_off,
                  color: ColorConstants.eyeColor,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  toggle = !toggle;

                  widget.isPassword = !widget.isPassword;
                  //print(widget.isPassword);
                  setState(
                    () {},
                  );
                },
              )
            : null,
        disabledBorder: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
