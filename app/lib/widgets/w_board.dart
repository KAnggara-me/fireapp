import '../constant/colors.dart';
import 'package:flutter/material.dart';
import '../views/board/v_board_detail.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:maps_launcher/maps_launcher.dart';

class Board extends StatelessWidget {
  const Board({
    Key? key,
    required this.id,
    required this.lat,
    required this.lon,
    required this.mq2,
    required this.name,
    required this.temp,
    required this.time,
    required this.mq2Max,
    required this.humiMax,
    required this.tempMax,
  }) : super(key: key);
  final int id;
  final DateTime time;
  final int? mq2Max, tempMax, humiMax;
  final double lat, lon, mq2, temp;
  final String name;

  @override
  Widget build(BuildContext context) {
    Color card = temp > tempMax! ? kCardRed : kCardGreen;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BoardDetail(
              id: id,
              name: name,
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
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              (temp >= tempMax! ? Colors.amber : Colors.black),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  ElevatedButton(
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
                      name,
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
                        children: <Widget>[
                          Text(
                            'Temperatur',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: (temp >= tempMax!
                                  ? Colors.white
                                  : Colors.black),
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
                          Row(
                            children: [
                              Text(
                                'Sensor Asap :   ',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  color: (temp >= tempMax!
                                      ? Colors.white
                                      : Colors.black),
                                ),
                              ),
                              Text(
                                temp >= tempMax! ? 'Tidak Aktif' : 'Aktif',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: (temp >= tempMax!
                                      ? Colors.amber
                                      : Colors.green),
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
                            color: (temp >= tempMax!
                                ? Colors.white
                                : Colors.black),
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
                        Text(
                          timeago.format(
                            time,
                            locale: 'id',
                            allowFromNow: true,
                          ),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: (temp >= tempMax!
                                ? Colors.white
                                : Colors.black),
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
      ),
    );
  }
}
