import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatefulWidget {
  final Function onChange;
  Stream<Object> blocStream;


  PasswordField({Key? key,required this.onChange,required this.blocStream}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.blocStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.inter(
                textStyle: TextStyle(color: Colors.black, fontSize: 14),
              ),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: "Password",
                //labelText: "Email Address",
                errorText: (snapshot.error.toString() == "null")
                    ? null
                    : snapshot.error.toString(),
                hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 14),
                ),
                disabledBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // onChanged: loginBloc.emailChanges,
            ),
          );
        });
  }
}
