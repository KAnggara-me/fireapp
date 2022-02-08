import '../../constant/url.dart';
import '../../widgets/w_board.dart';
import '../../constant/colors.dart';
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
    // ignore: avoid_print
    print(API.board);
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
                itemCount: listModel.length,
                itemBuilder: (context, i) {
                  final nDataList = listModel[i];
                  return Board(
                    id: nDataList.id,
                    lon: nDataList.temp.toDouble(),
                    lat: nDataList.humidity.toDouble(),
                    name: nDataList.ruangan,
                    temp: nDataList.temp,
                    time: nDataList.updatedAt,
                    humidity: nDataList.humidity,
                    tempMax: 40,
                    tempOp: ">",
                    humiMax: 50,
                    humiOp: ">",
                    mq2Max: 220,
                    mq2Op: ">",
                  );
                },
              ),
      ),
    );
  }
}
