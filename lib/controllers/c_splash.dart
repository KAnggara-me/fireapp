import './c_auth.dart';
import './c_navbar.dart';
import '../constant/size.dart';
import '../views/splash/v_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? notif = preferences.getInt("notif") ?? 0;
    if (notif == 1) {
      // subscribe to topic on each app start-up
      if (!kIsWeb) {
        await FirebaseMessaging.instance.subscribeToTopic('api');
      } else {
        if (kDebugMode) {
          print("Notification disabled on web");
        }
      }
    } else if (notif == 0) {
      if (!kIsWeb) {
        await FirebaseMessaging.instance.unsubscribeFromTopic('api');
      } else {
        if (kDebugMode) {
          print("Notification disabled on web");
        }
      }
    }
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
        if (kDebugMode) {
          print("Status => $status");
        }
      },
    );
  }
}
