
import 'package:flutter/material.dart';
import 'package:katra/constant/assets.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 240,
        width: 198,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            image: AssetImage(ImageAssets.LoginScreen),
          ),
        ),
      ),
    );
  }
}
