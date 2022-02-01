import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fire_app/constant/url.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fire_app/models/m_board_detial.dart';

class BoardDetail extends StatefulWidget {
  final int id;

  const BoardDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _BoardDetailState createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  // Membuat List Dari data Internet
  List<BoardDetailModel> listModel = [];
  var loading = false;

  Future<void> getData() async {
    setState(() {
      loading = true;
    });

    final responseData = await API.getBoardDetail(widget.id.toString());

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      // ignore: avoid_print
      print(data);
      setState(() {
        for (Map<String, dynamic> i in data) {
          listModel.add(BoardDetailModel.fromJson(i));
        }
        loading = false;
      });
    }
  }

  //Panggil Data / Call Data
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page List User'),
        centerTitle: true,
      ),
      body: Container(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listModel.length,
                itemBuilder: (context, i) {
                  final sensorList = listModel[i];
                  return InkWell(
                    onTap: () {
                      // ignore: avoid_print
                      print(sensorList.id);
                    },
                    child: Card(
                      color: Colors.amber[100],
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              sensorList.ruangan,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.green),
                            ),
                            Text(timeago.format(
                              sensorList.createdAt,
                              locale: 'id',
                              allowFromNow: true,
                            )),
                            Text(timeago.format(
                              sensorList.updatedAt,
                              locale: 'id',
                              allowFromNow: true,
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
