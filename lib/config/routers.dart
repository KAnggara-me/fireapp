import '../controllers/c_auth.dart';
import 'package:flutter/widgets.dart';
import '../controllers/c_navbar.dart';
import '../controllers/c_splash.dart';
import '../controllers/c_setting.dart';

final Map<String, WidgetBuilder> routes = {
  UserScreen.routeName: (context) => const UserScreen(),
  SplashPage.routeName: (context) => const SplashPage(),
  AdminScreen.routeName: (context) => const AdminScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SettingScreen.routeName: (context) => const SettingScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
};
