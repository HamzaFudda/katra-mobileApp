
import 'package:flutter/material.dart';

import '../../../constant/assets.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // height: 240,
                  // width: 198,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image(
                      image: AssetImage(ImageAssets.requestScreen),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        /* Do something here if you want */
        return false;
      },
    );
  }
}
