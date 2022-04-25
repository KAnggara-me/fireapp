import 'dart:convert';
import '../constant/url.dart';
import '../constant/size.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../views/setting/v_setting.dart';
import '../views/setting/v_setting_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = '/setting';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: const SettingPage(),
    );
  }
}

abstract class SettingController extends State<Setting> {
  bool loading = false;
  late int? mq2Max, tempMax;
  String msg = '', tempmsg = '', mq2msg = '';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController mq2 = TextEditingController();
  TextEditingController temp = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await _prefs;
    setState(() {
      mq2Max = preferences.getInt("mq2Max");
      tempMax = preferences.getInt("tempMax");
      mq2.text = mq2Max.toString();
      temp.text = tempMax.toString();
    });
  }

  cek() {
    if (tempmsg.isNotEmpty) {
      setState(() {
        msg = tempmsg + '\n';
      });
    } else if (mq2msg.isNotEmpty) {
      setState(() {
        msg = mq2msg + '\n';
      });
    } else {
      setState(
        () {
          loading = true;
        },
      );
      submit();
    }
  }

  Future<void> submit() async {
    Map body = {
      "mq2": mq2.text,
      "temperature": temp.text,
    };

    final response = await http.post(
      API.setting,
      body: body,
      headers: API.headers,
      encoding: Encoding.getByName("utf-8"),
    );
    Map<String, dynamic> data = json.decode(response.body);

    int mq2Max = data['mq2'] ?? 350;
    int tempMax = data['temp'] ?? 40;
    int humiMax = data['humidity'] ?? 40;
    String status = data['status'] ?? "";
    String pesan = data['message'] ?? "";
    savePref(
      mq2Max,
      tempMax,
      humiMax,
    );

    if (status == "success") {
      setState(
        () {
          loading = false;
          msg = pesan + '\n';
        },
      );
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    } else {
      setState(
        () {
          loading = false;
          msg = "Oops, something went wrong";
        },
      );
    }
  }

  savePref(
    mq2Max,
    tempMax,
    humiMax,
  ) async {
    SharedPreferences preferences = await _prefs;
    setState(() {
      preferences.setInt("mq2Max", mq2Max);
      preferences.setInt("tempMax", tempMax);
      preferences.setInt("humiMax", humiMax);
    });
  }

  //Config for Temperature section
  TextFormField tempField() {
    return TextFormField(
      controller: temp,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      onChanged: (value) {
        if (value.isNotEmpty) {
          tempmsg = '';
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          tempmsg = "Please Enter Max Temperature";
        }
        return;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Max Temperature",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)!,
          ),
          child: Icon(
            Icons.thermostat_outlined,
            size: SizeConfig.screenHeight * 0.04,
          ),
        ),
      ),
    );
  }

  //Config for mq2 section
  TextFormField mq2Field() {
    return TextFormField(
      controller: mq2,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      onChanged: (value) {
        if (value.isNotEmpty) {
          mq2msg = '';
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          mq2msg = "Please Enter Max CO₂ Value";
        }
        return;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Max CO₂ Value",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)!,
          ),
          child: Icon(
            Icons.co2,
            size: SizeConfig.screenHeight * 0.04,
          ),
        ),
      ),
    );
  }
}
