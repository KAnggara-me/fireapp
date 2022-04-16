import '../../main.dart';
import '../helpers/fcm.dart';
import 'package:flutter/material.dart';

abstract class MainController extends State<MyApp> {
  String dataNotif = "Data Notif";
  String titleNotif = "Title Notif";
  String bodyNotif = "Body Notif";
  @override
  void initState() {
    super.initState();
    final firebaseMsg = FCM();
    firebaseMsg.notif();

    firebaseMsg.dataCtrl.stream.listen(_updateData);
    firebaseMsg.titleCtrl.stream.listen(_updateTitle);
    firebaseMsg.bodyCtrl.stream.listen(_updateBody);
  }

  _updateData(String msg) => setState(() {
        dataNotif = msg;
      });
  _updateTitle(String msg) => setState(() {
        titleNotif = msg;
      });
  _updateBody(String msg) => setState(() {
        bodyNotif = msg;
      });
}
