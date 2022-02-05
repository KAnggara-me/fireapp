import 'dart:async';
import '../models/m_logs.dart';
import '../views/logs/v_log.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

abstract class LogController extends State<LogPage> {
  // Membuat List Dari data Internet
  List<LogModel> listModel = [];
  var loading = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
