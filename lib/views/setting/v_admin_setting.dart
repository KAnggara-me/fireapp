import '../../controllers/c_setting.dart';
import '../../widgets/w_setting.dart';
import 'package:flutter/material.dart';

class AdminSetting extends StatefulWidget {
  const AdminSetting({Key? key}) : super(key: key);

  @override
  _AdminSettingState createState() => _AdminSettingState();
}

class _AdminSettingState extends AdminSettingController {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SettingMenu(
            text: "My Account",
            icon: Icons.person,
            press: () => {},
          ),
        ],
      ),
    );
  }
}
