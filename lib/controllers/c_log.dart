import 'dart:async';
import 'dart:convert';
import '../constant/url.dart';
import '../models/m_logs.dart';
import '../views/logs/v_log.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LogController extends State<LogPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Membuat List Dari data Internet
  List<LogModel> logModel = [];
  late Timer timer;
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
    timer = Timer.periodic(
      const Duration(
        seconds: 5,
      ),
      (t) => getData(),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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

  Future<void> getData() async {
    if (status == 1) {
      url = API.getAllLog();
    } else {
      url = API.getLogById(userId);
    }
    final responseData = await url;

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      if (mounted) {
        setState(
          () {
            logModel = [];
            for (Map<String, dynamic> i in data) {
              logModel.add(
                LogModel.fromJson(i),
              );
            }
            loading = false;
          },
        );
      }
    }
  }
}
