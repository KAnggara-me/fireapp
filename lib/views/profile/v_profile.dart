import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../controllers/c_profile.dart';
import '../../widgets/w_profile_menu.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends ProfileController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  isConnect
                      ? CircleAvatar(
                          backgroundColor: Colors.white70,
                          foregroundColor: Colors.black,
                          backgroundImage: NetworkImage(imageUrl),
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileMenu(
              text: "My Account",
              icon: Icons.person,
              press: () {
                setting();
              },
            ),
            Notif(
              text: "Notifications ",
              notif: notif == 0 ? "Non Active" : "Active",
              color: notif == 0
                  ? const Color(0xFF9B2226)
                  : const Color(0xFF06b3fa),
              icon: notif == 0 ? Icons.notifications_off : Icons.notifications,
              press: () {
                if (kIsWeb) {
                  webNotification();
                } else {
                  notification();
                }
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icons.settings,
              press: () {
                setting();
              },
            ),
            ProfileMenu(
              text: "Help Center | id : " + uid.toString(),
              icon: Icons.help,
              press: () {
                help();
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.exit_to_app,
              press: () {
                signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
