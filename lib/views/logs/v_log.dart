import '../../constant/colors.dart';
import '../../widgets/w_sensor.dart';
import '../../controllers/c_log.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class LogPage extends StatefulWidget {
  const LogPage({
    Key? key,
  }) : super(key: key);

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends LogController {
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
          'Riwayat Notifikasi',
          style: TextStyle(
            color: kWhite,
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: logModel.length,
                itemBuilder: (context, i) {
                  final logData = logModel[i];
                  return Sensor(
                    mq2Max: mq2Max,
                    humiMax: humiMax,
                    tempMax: tempMax,
                    id: logData.id,
                    mq2: logData.mq2,
                    lat: logData.humidity.toDouble(),
                    lon: logData.temp.toDouble(),
                    temp: logData.temp,
                    name: logData.ruangan,
                    notif: logData.notif,
                    status: logData.status,
                    time: logData.updatedAt,
                    boardId: logData.boardId,
                    ruangan: logData.ruangan,
                    humidity: logData.humidity,
                  );
                },
              ),
      ),
    );
  }
}
