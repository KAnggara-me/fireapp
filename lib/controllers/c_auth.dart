import 'dart:convert';
import '../constant/url.dart';
import '../constant/size.dart';
import '../constant/text.dart';
import '../views/auth/v_login.dart';
import '../controllers/c_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../views/auth/v_login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: LoginBody(),
    );
  }
}

abstract class LoginController extends State<Login> {
  String msg = '', pmsg = '', emsg = '';
  bool _secureText = true, remember = true;
  final List<String> errors = [];

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  showHide() {
    setState(() {
      _secureText = !_secureText;
      msg = '';
    });
  }

  forgot() {
    Navigator.pushNamed(
      context,
      AdminScreen.routeName,
    );
  }

  guest() {
    Navigator.pushNamed(
      context,
      AdminScreen.routeName,
    );
  }

  cek() {
    if (emsg.isNotEmpty) {
      setState(() {
        msg = emsg + '\n';
      });
    } else if (pmsg.isNotEmpty) {
      setState(() {
        msg = pmsg + '\n';
      });
    } else {
      login();
    }
  }

  bool loading = false;

  Future<void> login() async {
    Map body = {
      "email": user.text,
      "password": pass.text,
    };

    final response = await http.post(
      API.login,
      body: body,
      headers: API.headers,
      encoding: Encoding.getByName("utf-8"),
    );
    Map<String, dynamic> data = json.decode(response.body);

    int id = data['id'] ?? 0;
    int status = data['status'] ?? 0;
    int mq2Max = data['mq2_max'] ?? 0;
    int tempMax = data['temp_max'] ?? 0;
    int humiMax = data['humi_max'] ?? 0;
    int noWa = data['help_wa'] ?? 6282284705204;
    String name = data['name'] ?? '';
    String email = data['email'] ?? '';
    String password = data['password'];
    String pesan = data['messege'] ?? "";
    String mq2Op = data['mq2_op'] ?? "=";
    String humiOp = data['humi_op'] ?? "=";
    String tempOp = data['temp_op'] ?? "=";
    String helpWa = noWa.toString();
    String helpMsg = data['help_msg'] ?? "Fire-App";
    remember
        ? savePref(
            id,
            name,
            email,
            mq2Op,
            status,
            mq2Max,
            humiOp,
            tempOp,
            helpWa,
            helpMsg,
            tempMax,
            humiMax,
            password,
          )
        : savePref(
            0,
            '',
            '',
            '',
            0,
            0,
            '',
            '',
            '',
            '',
            0,
            0,
            '',
          );

    if (data.isEmpty) {
      setState(() {
        msg = "Error";
      });
    } else {
      if (status == 2) {
        Navigator.pushReplacementNamed(context, UserScreen.routeName);
      } else if (status == 1) {
        Navigator.pushReplacementNamed(context, AdminScreen.routeName);
      }
      setState(
        () {
          msg = pesan + '\n';
        },
      );
    }
  }

  savePref(
    id,
    name,
    email,
    mq2Op,
    status,
    mq2Max,
    humiOp,
    tempOp,
    helpWa,
    helpMsg,
    tempMax,
    humiMax,
    password,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("intro", id);
      preferences.setInt("status", status);
      preferences.setInt("mq2Max", mq2Max);
      preferences.setInt("tempMax", tempMax);
      preferences.setInt("humiMax", humiMax);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("mq2Op", mq2Op);
      preferences.setString("tempOp", tempOp);
      preferences.setString("humiOp", humiOp);
      preferences.setString("helpWa", helpWa);
      preferences.setString("helpMsg", helpMsg);
      preferences.setString("password", password);
    });
  }

  //Config for Username section
  TextFormField usernameField() {
    return TextFormField(
      controller: user,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          emsg = '';
        } else if (emailValidatorRegExp.hasMatch(value)) {
          emsg = '';
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          emsg = kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          emsg = kInvalidEmailError;
        }
        return;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Username/Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)!,
          ),
          iconSize: SizeConfig.screenHeight * 0.04,
          onPressed: () {},
          icon: const Icon(
            Icons.mail,
          ),
        ),
      ),
    );
  }

  //Config for passwordd section
  TextFormField passwordField() {
    return TextFormField(
      controller: pass,
      obscureText: _secureText,
      onChanged: (value) {
        if (value.isNotEmpty) {
          pmsg = '';
        } else if (value.length >= 6) {
          pmsg = '';
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          pmsg = kPassNullError;
        } else if (value.length < 6) {
          pmsg = kShortPassError;
        }
        return;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)!,
          ),
          iconSize: SizeConfig.screenHeight * 0.04,
          onPressed: showHide,
          icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
