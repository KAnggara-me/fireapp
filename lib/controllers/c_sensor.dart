import 'dart:async';
import 'dart:convert';
import '../constant/url.dart';
import '../models/m_sensor.dart';
import '../views/sensor/v_sensor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SensorController extends State<SensorPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Membuat List Dari data API
  List<SensorModel> listModel = [];

  late Timer stimer;
  var loading = false;
  int? mq2Max, tempMax, humiMax, status;
  late String tempOp, humiOp, mq2Op, userId;
  late Future<dynamic> url;

  //Panggil Data / Call Data
  @override
  void initState() {
    super.initState();
    loading = true;
    getPref();
    stimer = Timer.periodic(
      const Duration(
        seconds: 5,
      ),
      (t) => getData(),
    );
  }

  @override
  void dispose() {
    stimer.cancel();
    super.dispose();
  }

  Future<void> getData() async {
    if (status == 1) {
      url = API.getAllSensor();
    } else {
      url = API.getSensorById(userId);
    }

    final responseData = await url;
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      if (mounted) {
        setState(
          () {
            listModel = [];
            for (Map<String, dynamic> i in data) {
              listModel.add(
                SensorModel.fromJson(i),
              );
            }
            loading = false;
          },
        );
      }
    }
  }

  getPref() async {
    final SharedPreferences pref = await _prefs;
    if (mounted) {
      setState(() {
        mq2Max = pref.getInt("mq2Max");
        status = pref.getInt("status");
        tempMax = pref.getInt("tempMax");
        humiMax = pref.getInt("humiMax");
        userId = pref.getInt("uid").toString();
        mq2Op = pref.getString("mq2Op").toString();
        tempOp = pref.getString("tempOp").toString();
        humiOp = pref.getString("humiOp").toString();
      });
    }
    getData();
  }
}
