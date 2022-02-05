import 'package:fire_app/views/logs/v_log.dart';
import 'package:fire_app/views/profile/v_profile.dart';

import '../views/board/v_board.dart';
import '../views/navbar/nav_user.dart';
import 'package:flutter/material.dart';
import '../views/navbar/nav_admin.dart';

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

  Widget showPage = const BoardPage();

  final BoardPage _adminHomeScreen = const BoardPage();
  final ProfileBody _userProfile = const ProfileBody();
  final BoardPage _dashboardScreen = const BoardPage();
  final LogPage _logPage = const LogPage();

  pageChooser(int page) {
    switch (page) {
      case 0:
        return _adminHomeScreen;
      case 1:
        return _dashboardScreen;
      case 2:
        return _logPage;
      case 3:
        return _userProfile;
      default:
        return const Center(
          child: Text("Page Not Availabel yet...!"),
        );
    }
  }
}

abstract class UserNavController extends State<UserNavBar> {
  int pageIndex = 0;

  Widget showPage = const BoardPage();

  final BoardPage _sensorIdScreen = const BoardPage();
  final ProfileBody _userProfile = const ProfileBody();
  final LogPage _logPage = const LogPage();

  pageChooser(int page) {
    switch (page) {
      case 0:
        return _sensorIdScreen;
      case 1:
        return _logPage;
      case 2:
        return _userProfile;
      default:
        return const Center(
          child: Text("Page Not Availabel yet...!"),
        );
    }
  }
}
