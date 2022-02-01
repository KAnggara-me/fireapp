import 'dart:async';
import 'dart:convert';
import 'package:fire_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fire_app/constant/url.dart';
import 'package:fire_app/models/m_board.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fire_app/views/board/v_board_detail.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({
    Key? key,
  }) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  // Membuat List Dari data Internet
  List<BoardModel> listModel = [];
  var loading = false;
  int humidity = 50;
  int temp = 40;
  late Timer timer;

  Future<void> getData() async {
    setState(() {
      listModel = [];
    });

    final responseData = await http.get(API.board);

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      // TODO: handle success
      // ignore: avoid_print
      print(data);
      setState(
        () {
          for (Map<String, dynamic> i in data) {
            listModel.add(BoardModel.fromJson(i));
          }
          loading = false;
        },
      );
    }
  }

  //Panggil Data / Call Data
  @override
  void initState() {
    super.initState();
    loading = true;
    getData();
    timer = Timer.periodic(
      const Duration(
        seconds: 5,
      ),
      (t) => getData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages(
      'id',
      timeago.IdMessages(),
    );
    // ignore: avoid_print
    print(API.board);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Sensor Terpasang',
          style: TextStyle(
            color: kBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: listModel.length,
                itemBuilder: (context, i) {
                  final nDataList = listModel[i];
                  Color card =
                      nDataList.temp >= temp || nDataList.humidity <= humidity
                          ? kCardRed
                          : kCard;
                  Color text =
                      nDataList.temp >= temp || nDataList.humidity <= humidity
                          ? kWhite
                          : kCard;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoardDetail(
                            id: nDataList.id,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: card,
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  nDataList.name,
                                  style: const TextStyle(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: kWhite,
                                        offset: Offset(8, 8),
                                      ),
                                    ],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: kBlack,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      kBGcolor,
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      kWhite,
                                    ),
                                  ),
                                  onPressed: () =>
                                      MapsLauncher.launchCoordinates(
                                    nDataList.lat,
                                    nDataList.lon,
                                    nDataList.name,
                                  ),
                                  child: const Text('Buka Lokasi'),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: kBlack,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: <Widget>[
                                    const Text(
                                      'Temperatur',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                        color: kBlack,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      nDataList.temp.toString() + '°C',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        color: kWhite,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Status Sensor Asap :   ',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12,
                                            color: kBlack,
                                          ),
                                        ),
                                        Text(
                                          nDataList.temp >= temp
                                              ? 'Aktif'
                                              : 'Tidak Aktif',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: (nDataList.temp >= temp
                                                ? Colors.green
                                                : Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    const Text(
                                      'Kelembapan',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                        color: kBlack,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      nDataList.humidity.toString() + ' %',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        color: kWhite,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Diperbaharui :   ' +
                                          timeago.format(
                                            nDataList.updatedAt,
                                            locale: 'id',
                                            allowFromNow: true,
                                          ),
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12,
                                        color: kBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
