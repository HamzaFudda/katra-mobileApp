import 'package:flutter/material.dart';
import 'package:katra/constant/color.dart';

class BottomNavbar extends StatefulWidget {
  Function(int) onPressed;

  BottomNavbar({Key? key, required this.onPressed}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
  //    selectedItemColor: Color.fromRGBO(30, 159, 217, 1),
      type: BottomNavigationBarType.fixed,
      //backgroundColor: ,
      selectedItemColor:ColorConstants.button_color ,
      //unselectedItemColor: ,
      currentIndex: index,
      onTap: (curIndex) {
        setState(() {
          index = curIndex;
        });
        widget.onPressed(index);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "",
            backgroundColor: ColorConstants.navbarIconsColor),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: "",
            backgroundColor: ColorConstants.navbarIconsColor),
      ],
    );
  }
}
