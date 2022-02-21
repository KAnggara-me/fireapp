import '../../widgets/w_sensor.dart';
import 'package:flutter/material.dart';
import '../../controllers/c_sensor.dart';
import 'package:timeago/timeago.dart' as timeago;

class SensorPage extends StatefulWidget {
  const SensorPage({
    Key? key,
  }) : super(key: key);

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends SensorController {
  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages(
      'id',
      timeago.IdMessages(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          'Sensor Terpasang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        actions: [
          status == 2
              ? IconButton(
                  onPressed: () {
                    openDialoog();
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    admin();
                  },
                  icon: const Icon(
                    Icons.do_disturb_alt_sharp,
                    color: Colors.lightBlue,
                    size: 30,
                  ),
                ),
        ],
      ),
      body: Container(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
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
                    temp: sensorData.temp,
                    name: sensorData.name,
                    notif: sensorData.notif,
                    status: sensorData.status,
                    time: sensorData.updatedAt,
                    boardId: sensorData.boardId,
                    ruangan: sensorData.ruangan,
                    humidity: sensorData.humidity,
                  );
                },
              ),
      ),
    );
  }
}
