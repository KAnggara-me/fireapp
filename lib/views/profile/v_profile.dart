import 'package:fire_app/controllers/c_profile.dart';
import 'package:fire_app/widgets/w_profile_menu.dart';
import 'package:flutter/material.dart';

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
        title: const Text(
          "Profile",
          style: TextStyle(
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
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icons.notifications,
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icons.settings,
              press: () {
                setting();
              },
            ),
            ProfileMenu(
              text: "Help Center",
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
