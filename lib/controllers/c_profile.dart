import './c_auth.dart';
import '../constant/url.dart';
import 'package:flutter/material.dart';
import '../views/profile/v_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileController extends State<ProfileBody> {
  bool isConnect = false;
  late String name, email, imageUrl, password, helpMsg, helpWa;
  int? status;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  help() async {
    if (await canLaunch(WA.getHelp(
      helpWa,
      helpMsg,
    ))) {
      await launch(
        WA.getHelp(
          helpWa,
          helpMsg,
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

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getInt("status");
      name = preferences.getString("name").toString();
      email = preferences.getString("email").toString();
      helpWa = preferences.getString("helpWa").toString();
      helpMsg = preferences.getString("helpMsg").toString();
      password = preferences.getString("password").toString();
      imageUrl = BaseUrl.image;
      isConnect = true;
    });
  }

  setting() {
    // if (status == 1) {
    //   Navigator.pushNamed(context, AdminSettingScreen.routeName);
    // } else {
    //   Navigator.pushNamed(context, UserSettingScreen.routeName);
    // }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Coming Soon...."),
      ),
    );
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("intro", 0);
      preferences.setInt("status", 0);
      preferences.setInt("mq2Max", 0);
      preferences.setInt("tempMax", 0);
      preferences.setInt("humiMax", 0);
      preferences.setString("name", '');
      preferences.setString("pesan", '');
      preferences.setString("email", '');
      preferences.setString("mq2Op", '');
      preferences.setString("tempOp", '');
      preferences.setString("humiOp", '');
      preferences.setString("helpWa", '');
      preferences.setString("helpMsg", '');
      preferences.setString("password", '');
      Navigator.pushReplacementNamed(
        context,
        LoginScreen.routeName,
      );
    });
  }
}
