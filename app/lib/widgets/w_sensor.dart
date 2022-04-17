import '../constant/text.dart';
import '../constant/colors.dart';
import 'package:flutter/material.dart';
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
    Color card, title, tnotif, tupdate;
    String notif;
    if (temp >= tempMax! && mq2 > mq2Max!) {
      card = kCardRed; //Red
      notif = kNotiffire;
      title = Colors.amber;
      tnotif = Colors.amber;
      tupdate = Colors.white;
    } else if (temp >= tempMax!) {
      card = kCardOrange; //Orange
      title = Colors.black;
      tnotif = Colors.red;
      tupdate = Colors.black;
      notif = kNotifTmp;
    } else if (mq2 > mq2Max!) {
      card = kCardGrey; //Grey
      notif = kNotifsmoke;
      title = Colors.white;
      tnotif = Colors.amber;
      tupdate = Colors.black;
    } else {
      notif = kNotifOK;
      card = kCardGreen; //Green
      title = Colors.black;
      tnotif = Colors.blue;
      tupdate = Colors.black;
    }
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Delete Sensor Feature: Cooming soon...",
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: FittedBox(
                      child: Text(
                        ruangan ?? "Unknown",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: title,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
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
                              color: tupdate,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            temp.toString() + '°C',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: kWhite,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sensor Asap :   ',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  color: tupdate,
                                ),
                              ),
                              Text(
                                notif,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: tnotif,
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
                        Text(
                          'Sensor MQ-2',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: tupdate,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          mq2.toString() + ' ppm',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: kWhite,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              'Update:   ',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: tupdate,
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
                                fontSize: 10,
                                color: tupdate,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
