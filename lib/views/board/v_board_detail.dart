import 'package:flutter/material.dart';
import '../../controllers/c_board.dart';
import '../../widgets/w_sensor.dart';

class BoardDetail extends StatefulWidget {
  const BoardDetail({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  final int id;
  final String name;

  @override
  _BoardDetailState createState() => _BoardDetailState();
}

class _BoardDetailState extends DetailController {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          '$name Sensor List',
          style: const TextStyle(
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
                  final sensorData = listModel[i];
                  return Sensor(
                    mq2Max: mq2Max,
                    humiMax: humiMax,
                    tempMax: tempMax,
                    id: sensorData.id,
                    mq2: sensorData.mq2,
                    lat: sensorData.lat,
                    lon: sensorData.lon,
                    temp: sensorData.temp.toDouble(),
                    name: sensorData.name,
                    time: sensorData.updatedAt,
                    boardId: sensorData.boardId,
                    ruangan: sensorData.ruangan,
                    humidity: sensorData.humidity.toDouble(),
                  );
                },
              ),
      ),
    );
  }
}
