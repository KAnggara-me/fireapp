import '../views/sensor/v_sensor.dart';
import '../views/logs/v_log.dart';
import '../views/board/v_board.dart';
import '../views/navbar/nav_user.dart';
import 'package:flutter/material.dart';
import '../views/navbar/nav_admin.dart';
import '../views/profile/v_profile.dart';

class AdminScreen extends StatelessWidget {
  static String routeName = '/admin';

  const AdminScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AdminNavBar(),
    );
  }
}

class UserScreen extends StatelessWidget {
  static String routeName = '/user';
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UserNavBar();
  }
}

abstract class AdminNavBarController extends State<AdminNavBar> {
  int pageIndex = 0;

  final items = <Widget>[
    const Icon(Icons.home, size: 30),
    const Icon(Icons.developer_board_outlined, size: 30),
    const Icon(Icons.history_toggle_off_outlined, size: 30),
    const Icon(Icons.person, size: 30),
  ];

  final screen = [
    const BoardPage(),
    const SensorPage(),
    const LogPage(),
    const ProfileBody(),
  ];
}

abstract class UserNavController extends State<UserNavBar> {
  int pageIndex = 0;

  Widget showPage = const BoardPage();

  final screen = [
    const SensorPage(),
    const LogPage(),
    const ProfileBody(),
  ];

  final items = <Widget>[
    const Icon(Icons.home, size: 30),
    const Icon(Icons.history_toggle_off_outlined, size: 30),
    const Icon(Icons.person, size: 30),
  ];
}
