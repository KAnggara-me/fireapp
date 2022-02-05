import '../constant/size.dart';
import 'package:flutter/material.dart';
import '../views/setting/v_user_setting.dart';
import '../views/setting/v_admin_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingScreen extends StatelessWidget {
  static String routeName = '/userSetting';
  const UserSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AdminSettingScreen extends StatelessWidget {
  static String routeName = '/adminSetting';
  const AdminSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: const AdminSetting(),
    );
  }
}

abstract class UserSettingController extends State<UserSetting> {}

abstract class AdminSettingController extends State<AdminSetting> {
  late String helpWa, helpMsg, tempOp, humiOp, mq2Op;
  int? mq2Max, tempMax, humiMax;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mq2Max = preferences.getInt("mq2Max");
      tempMax = preferences.getInt("tempMax");
      humiMax = preferences.getInt("humiMax");
      mq2Op = preferences.getString("mq2Op").toString();
      helpWa = preferences.getString("helpWa").toString();
      tempOp = preferences.getString("tempOp").toString();
      humiOp = preferences.getString("humiOp").toString();
      helpMsg = preferences.getString("helpMsg").toString();
    });
  }
}
