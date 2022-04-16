import 'dart:async';
import 'dart:convert';
import '../constant/url.dart';
import '../models/m_sensor.dart';
import '../views/sensor/v_sensor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class SensorController extends State<SensorPage> {
  late Timer stimer;
  var loading = false;
  late Future<dynamic> url;
  // Membuat List Dari data API
  List<SensorModel> listModel = [];
  int? mq2Max, tempMax, humiMax, status;
  late String tempOp, humiOp, mq2Op, userId;
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

  admin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Only Available for User"),
      ),
    );
  }

  Future openDialoog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Nama Ruangan :"),
          content: TextField(
            autofocus: true,
            controller: ruangan,
            decoration: const InputDecoration(
              hintText: "Masukan Nama Ruangan",
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 40,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                cek();
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      );

  cek() {
    if (ruangan.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mohon Masukan Nama Ruangan"),
        ),
      );
      Navigator.of(context).pop();
    } else {
      addSensor();
    }
  }

  Future<void> addSensor() async {
    Map body = {
      "board_id": userId.toString(),
      "mq2": mq2Max.toString(),
      "ruangan": ruangan.text,
      "humidity": "75",
      "status": "-",
      "notif": "-",
      "temp": "28",
    };

    final response = await http.post(
      API.sensor,
      body: body,
      headers: API.headers,
      encoding: Encoding.getByName("utf-8"),
    );
    Map<String, dynamic> data = json.decode(response.body);
    String pesan = data['messege'] ?? "";
    if (data.isEmpty || pesan != "Success") {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops, Something Wrong"),
        ),
      );
    } else {
      setState(
        () {
          ruangan.clear();
          loading = true;
          getData();
        },
      );
      Navigator.of(context).pop();
    }
  }
}
