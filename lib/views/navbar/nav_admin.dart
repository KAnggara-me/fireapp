import 'package:flutter/material.dart';
import '../../controllers/c_navbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({Key? key}) : super(key: key);

  @override
  _AdminNavBarState createState() => _AdminNavBarState();
}

class _AdminNavBarState extends AdminNavBarController {
  int tap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: tap == 0
                ? const Color(0xFF06b3fa)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
          Icon(
            Icons.developer_board_outlined,
            size: 30,
            color: tap == 1
                ? const Color(0xFF06b3fa)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
          Icon(
            Icons.history_toggle_off_outlined,
            size: 30,
            color: tap == 2
                ? const Color(0xFF06b3fa)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
          Icon(
            Icons.person,
            size: 30,
            color: tap == 3
                ? const Color(0xFF06b3fa)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (int tapedIndex) {
          setState(
            () {
              showPage = pageChooser(tapedIndex);
              tap = tapedIndex.toInt();
              print(tap);
            },
          );
        },
      ),
      body: showPage,
    );
  }
}
