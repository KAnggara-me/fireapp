import '../../constant/colors.dart';
import '../../widgets/w_board.dart';
import '../../controllers/c_board.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class BoardPage extends StatefulWidget {
  const BoardPage({
    Key? key,
  }) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends BoardController {
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
          'Lokasi Device Terpasang',
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
                    lon: nDataList.lon,
                    lat: nDataList.lat,
                    name: nDataList.name,
                    temp: nDataList.temp,
                    time: nDataList.updatedAt,
                    humidity: nDataList.humidity,
                    tempMax: tempMax,
                    humiMax: humiMax,
                    humiOp: humiOp,
                    tempOp: tempOp,
                    mq2Max: mq2Max,
                    mq2Op: mq2Op,
                  );
                },
              ),
      ),
    );
  }
}
