import '../constant/size.dart';
import '../constant/text.dart';
import '../constant/colors.dart';
import 'package:flutter/material.dart';
import '../views/sensor/v_update_sensor.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:maps_launcher/maps_launcher.dart';

class Sensor extends StatelessWidget {
  const Sensor({
    Key? key,
    required this.id,
    required this.mq2,
    required this.lat,
    required this.lon,
    required this.temp,
    required this.name,
    required this.time,
    required this.ruangan,
    required this.boardId,
    required this.humidity,
    required this.tempMax,
    required this.mq2Max,
    required this.humiMax,
  }) : super(key: key);
  final DateTime time;
  final int id, mq2, boardId;
  final int? mq2Max, tempMax, humiMax;
  final double lat, lon, temp, humidity;
  final dynamic ruangan, name;

  @override
  Widget build(BuildContext context) {
    Color card, title;
    Color cNotif, cTmp, cCo2, cUpdate;
    String notif;
    if (temp >= tempMax! && mq2 > mq2Max!) {
      card = kCardRed; //Red
      notif = kNotiffire;
      title = Colors.amber;
      cNotif = Colors.amber;
      cCo2 = Colors.amber;
      cTmp = Colors.amber;
      cUpdate = Colors.amber;
    } else if (temp >= tempMax!) {
      card = kCardOrange; //Orange
      title = Colors.black;
      cNotif = Colors.red;
      cUpdate = Colors.black;
      cCo2 = Colors.black;
      cTmp = Colors.red;
      notif = kNotifTmp;
    } else if (mq2 > mq2Max!) {
      card = kCardGrey; //Grey
      notif = kNotifsmoke;
      title = Colors.white;
      cNotif = Colors.amber;
      cCo2 = Colors.amber;
      cTmp = Colors.black;
      cUpdate = Colors.black;
    } else {
      notif = kNotifOK;
      card = kCardGreen; //Green
      title = Colors.black;
      cNotif = Colors.black;
      cCo2 = Colors.black;
      cTmp = Colors.black;
      cUpdate = Colors.black;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateSensor(
              id: id,
              ruangan: ruangan,
            ),
          ),
        );
      },
      child: Card(
        color: card,
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ruangan ?? "Unknown",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (ruangan.length > 12) ? (ruangan.length > 19 ? 10 : 15) : 22,
                      color: title,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  (lon == 0.0 && lat == 0.0)
                      ? const SizedBox()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.15,
                              MediaQuery.of(context).size.height * 0.04,
                            ),
                            maximumSize: Size(
                              MediaQuery.of(context).size.width * 0.3,
                              MediaQuery.of(context).size.height * 0.05,
                            ),
                            primary: kBGcolor,
                          ),
                          onPressed: () => MapsLauncher.launchCoordinates(
                            lat,
                            lon,
                            name ?? "Unamed",
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
                  Flexible(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Column(
                        children: [
                          Text(
                            'Temperatur',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: cUpdate,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            temp.toString() + '°C',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: (temp > 100) ? 25 : 35,
                              color: kWhite,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            (temp >= tempMax! ? 'Suhu Tinggi' : 'Suhu Normal'),
                            style: TextStyle(
                              color: cTmp,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Sensor MQ-2',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: cUpdate,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          mq2.toString() + ' ppm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (mq2 > 500) ? 25 : 35,
                            color: kWhite,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (mq2 >= mq2Max! ? 'Asap Terdeteksi' : 'Aman'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(15),
                            color: cCo2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                notif,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(25),
                  fontWeight: FontWeight.bold,
                  color: cNotif,
                ),
              ),
              Text(
                timeago.format(
                  time,
                  locale: 'id',
                  allowFromNow: true,
                ),
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: getProportionateScreenWidth(12),
                  color: (temp >= tempMax! ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
