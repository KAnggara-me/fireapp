import './c_auth.dart';
import './c_navbar.dart';
import '../constant/size.dart';
import '../views/splash/v_splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  static String routeName = "/splash";

  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}

abstract class SplashController extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        getPref();
      },
    );
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        int? status = preferences.getInt("status");
        if (status == 2) {
          Navigator.pushReplacementNamed(context, UserScreen.routeName);
        } else if (status == 1) {
          Navigator.pushReplacementNamed(context, AdminScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
        // ignore: avoid_print
        print("Status => $status");
      },
    );
  }
}
