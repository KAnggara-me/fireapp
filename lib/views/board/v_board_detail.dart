import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../controllers/c_board.dart';

class BoardDetail extends StatefulWidget {
  final int id;

  const BoardDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _BoardDetailState createState() => _BoardDetailState();
}

class _BoardDetailState extends DetailController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          'User Sensor List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listModel.length,
                itemBuilder: (context, i) {
                  final sensorList = listModel[i];
                  return Card(
                    color: const Color(0xFF94D2BD),
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: FittedBox(
                                  child: Text(
                                    sensorList.ruangan ?? "Unknown",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Temperatur',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18,
                                          color: (sensorList.temp >= 50
                                              ? Colors.white
                                              : Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        sensorList.temp.toString() + '°C',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Sensor Asap :   ',
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 12,
                                              color: (sensorList.temp >= 50
                                                  ? Colors.white
                                                  : Colors.black),
                                            ),
                                          ),
                                          Text(
                                            sensorList.notif ?? "Unknown",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: (sensorList.temp >= 50
                                                  ? Colors.amber
                                                  : Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      'Kelembapan',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      sensorList.humidity.toString() + ' %',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      timeago.format(
                                        sensorList.updatedAt,
                                        locale: 'id',
                                        allowFromNow: true,
                                      ),
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
