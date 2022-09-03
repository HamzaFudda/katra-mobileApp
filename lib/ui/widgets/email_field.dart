import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../di/locator.dart';
import '../screens/login_page/login_bloc.dart';

class EmailField extends StatefulWidget {
  //LoginBloc loginBloc = getItLocator.get<LoginBloc>();

  final Function onChange;
  Stream<Object> blocStream;

  EmailField({Key? key,required this.onChange,required this.blocStream}) : super(key: key);

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.blocStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.inter(
                textStyle: TextStyle(color: Colors.black, fontSize: 14),
              ),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: "Email",
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
              onChanged: widget.onChange(),
            ),
          );
        });
  }
}
