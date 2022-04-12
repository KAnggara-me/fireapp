import 'dart:async';
import 'dart:convert';
import '../constant/url.dart';
import '../models/m_board.dart';
import '../models/m_sensor.dart';
import '../views/board/v_board.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../views/board/v_board_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BoardController extends State<BoardPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Membuat List Dari data Internet
  List<BoardModel> listModel = [];
  var loading = false;
  late Timer timer;
  int? mq2Max, tempMax, humiMax;
  late String tempOp, humiOp, mq2Op;

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
      (t) {
        getData();
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> getData() async {
    final responseData = await http.get(API.board);

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      if (mounted) {
        setState(
          () {
            listModel = [];
            for (Map<String, dynamic> i in data) {
              listModel.add(
                BoardModel.fromJson(i),
              );
            }
            loading = false;
          },
        );
      }
    }
  }

  getPref() async {
    SharedPreferences preferences = await _prefs;
    if (mounted) {
      setState(() {
        mq2Max = preferences.getInt("mq2Max");
        tempMax = preferences.getInt("tempMax");
        humiMax = preferences.getInt("humiMax");
        mq2Op = preferences.getString("mq2Op").toString();
        tempOp = preferences.getString("tempOp").toString();
        humiOp = preferences.getString("humiOp").toString();
      });
    }
    getData();
  }
}

abstract class DetailController extends State<BoardDetail> {
  late Timer stimer;
  var loading = false;
  late Future<dynamic> url;
  // Membuat List Dari data API
  List<SensorModel> listModel = [];
  int? mq2Max, tempMax, humiMax, status;
  late String userId;
  TextEditingController ruangan = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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

  getPref() async {
    final SharedPreferences pref = await _prefs;
    if (mounted) {
      setState(() {
        mq2Max = pref.getInt("mq2Max");
        status = pref.getInt("status");
        tempMax = pref.getInt("tempMax");
        humiMax = pref.getInt("humiMax");
      });
    }
    getData();
  }

  Future<void> getData() async {
    int id = widget.id;
    url = API.getSensorById(id.toString());

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
}
