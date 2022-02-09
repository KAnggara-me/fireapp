import './config/themes.dart';
import './constant/text.dart';
import './config/routers.dart';
import './controllers/c_splash.dart';
import 'package:flutter/material.dart';

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
      initialRoute: SplashPage.routeName, //Redirect to Splash Screen
      routes: routes, //Setup Routes from routers.dart
    );
  }
}
