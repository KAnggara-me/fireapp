import './c_auth.dart';
import '../constant/url.dart';
import 'package:flutter/material.dart';
import '../views/profile/v_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'c_setting.dart';

abstract class ProfileController extends State<ProfileBody> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isConnect = false;
  late String email, imageUrl, password, helpMsg, helpWa;
  String name = 'Profile';
  int? status, notif, uid = 0;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  help(String uid) async {
    if (await canLaunch(WA.getHelp(
      helpWa,
      helpMsg,
    ))) {
      await launch(
        WA.getHelp(
          helpWa,
          helpMsg + uid,
        ),
        forceSafariVC: false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("whatsapp not installed"),
        ),
      );
    }
  }

  notification() async {
    SharedPreferences pref = await _prefs;
    if (notif == 1) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('api');
    } else if (notif == 0) {
      await FirebaseMessaging.instance.subscribeToTopic('api');
    }
    setState(() {
      if (notif == 1) {
        notif = 0;
      } else {
        notif = 1;
      }
      pref.setInt("notif", notif!);
    });
  }

  webNotification() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Notif not yet available for web"),
      ),
    );
  }

  getPref() async {
    SharedPreferences pref = await _prefs;
    setState(() {
      status = pref.getInt("status");
      uid = pref.getInt("uid");
      name = pref.getString("name").toString();
      email = pref.getString("email").toString();
      notif = (kIsWeb) ? 0 : pref.getInt("notif");
      helpWa = pref.getString("helpWa").toString();
      helpMsg = pref.getString("helpMsg").toString();
      password = pref.getString("password").toString();
      imageUrl = BaseUrl.image;
      isConnect = true;
    });
  }

  setting() {
    Navigator.pushNamed(context, SettingScreen.routeName);
  }

  signOut() async {
    SharedPreferences pref = await _prefs;
    if (!kIsWeb) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('api');
    }
    setState(() {
      pref.setInt("notif", 0);
      pref.setInt("intro", 0);
      pref.setInt("status", 0);
      pref.setInt("mq2Max", 0);
      pref.setInt("tempMax", 0);
      pref.setInt("humiMax", 0);
      pref.setString("name", '');
      pref.setString("pesan", '');
      pref.setString("email", '');
      pref.setString("mq2Op", '');
      pref.setString("tempOp", '');
      pref.setString("humiOp", '');
      pref.setString("helpWa", '');
      pref.setString("helpMsg", '');
      pref.setString("password", '');
      Navigator.pushReplacementNamed(
        context,
        LoginScreen.routeName,
      );
    });
  }
}
