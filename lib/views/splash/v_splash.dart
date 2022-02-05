import 'package:fire_app/controllers/c_splash.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends SplashController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 150),
          // Load a Lottie file from your assets
          Lottie.asset('assets/lottie/splash.json'),
        ],
      ),
    );
  }
}
