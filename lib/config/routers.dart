import '../controllers/c_auth.dart';
import '../controllers/c_navbar.dart';
import '../controllers/c_splash.dart';
import 'package:flutter/widgets.dart';
import '../controllers/c_setting.dart';

final Map<String, WidgetBuilder> routes = {
  UserScreen.routeName: (context) => const UserScreen(),
  SplashPage.routeName: (context) => const SplashPage(),
  AdminScreen.routeName: (context) => const AdminScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  UserSettingScreen.routeName: (context) => const UserSettingScreen(),
  AdminSettingScreen.routeName: (context) => const AdminSettingScreen(),
};
