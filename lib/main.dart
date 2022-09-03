import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katra/db_manager/local_storage_service.dart';
import 'package:katra/helper/my_connectivity.dart';
import 'package:katra/repos/login_repo.dart';
import 'package:katra/ui/screens/navbar_navigation_page/navbar_navigation_page.dart';
import 'package:katra/ui/screens/splash_page/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/prefrence_key.dart';
import 'di/locator.dart';
import 'models/response/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences.setMockInitialValues({});

  await SharedPreferenceUtil.init();
  await setupLocator();
  final connectivity = MyConnectivity.instance;
  connectivity.initialise();
  await getItLocator.get<LoginRepo>().getToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
