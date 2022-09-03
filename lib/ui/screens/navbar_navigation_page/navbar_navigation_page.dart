import 'package:flutter/material.dart';
import 'package:katra/ui/screens/homepage_page/homepage_page.dart';
import 'package:katra/ui/screens/profile_page/profile_page.dart';
import 'package:katra/ui/screens/request_page/request_page.dart';
import 'package:katra/ui/widgets/bottom_navbar.dart';

class NavBarNavigationPage extends StatefulWidget {
  const NavBarNavigationPage({Key? key}) : super(key: key);

  @override
  _NavBarNavigationPageState createState() => _NavBarNavigationPageState();
}

class _NavBarNavigationPageState extends State<NavBarNavigationPage> {
  int currentIndex = 0;
  final screens = [
    HomepagePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavbar(onPressed: (receivedIndex) {
        currentIndex = receivedIndex;
        setState(() {});
      }),
    );
  }
}
