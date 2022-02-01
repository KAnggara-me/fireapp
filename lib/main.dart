import 'package:fire_app/constant/text.dart';
import 'package:fire_app/views/board/v_board.dart';
// import 'package:fire_app/views/device/v_devices.dart';
import 'package:flutter/material.dart';
import 'config/themes.dart';
// import './config/routers.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Disable Debud banner on right top app
      title: kAppName,
      theme: theme(), //Theme for this App
      // initialRoute: SplashScreen, //Redirect to Splash Screen
      // routes: routes, //Setup Routes from routers.dart
      // home: const DevicePage(), //Redirect to Splash Screen
      home: const BoardPage(),
    );
  }
}
