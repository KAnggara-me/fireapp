import '../constant/colors.dart';
import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Card(
        child: Row(
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
              size: 22,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
