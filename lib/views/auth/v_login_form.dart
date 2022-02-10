// ignore_for_file: avoid_print

import 'package:fire_app/constant/colors.dart';
import 'package:fire_app/constant/size.dart';
import 'package:fire_app/controllers/c_auth.dart';
import 'package:fire_app/helpers/keyboard.dart';
import 'package:fire_app/widgets/w_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends LoginController {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          usernameField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          passwordField(),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (i) {
                  setState(() {
                    remember = i!;
                    print(i);
                  });
                },
              ),
              Text(
                "Remember me",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(12.5),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => forgot(),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: getProportionateScreenWidth(12.5),
                  ),
                ),
              )
            ],
          ),
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  msg,
                  style: const TextStyle(fontSize: 20.0, color: Colors.red),
                ),
          LoginButton(
            text: "Login",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                cek();
              }
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
        ],
      ),
    );
  }
}
