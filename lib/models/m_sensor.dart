import 'dart:convert';

List<SensorModel> sensorModelFromJson(String str) => List<SensorModel>.from(
    json.decode(str).map((x) => SensorModel.fromJson(x)));

String sensorModelToJson(List<SensorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SensorModel {
  SensorModel({
    required this.id,
    required this.mq2,
    required this.lat,
    required this.lon,
    required this.temp,
    required this.name,
    required this.notif,
    required this.status,
    required this.ruangan,
    required this.boardId,
    required this.humidity,
    required this.updatedAt,
  });
  DateTime updatedAt;
  int id, mq2, boardId;
  double lat, lon, temp, humidity;
  dynamic notif, status, ruangan;
  String name;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        id: json["id"],
        mq2: json["mq2"],
        temp: json["temp"],
        name: json["name"],
        notif: json["notif"],
        status: json["status"],
        ruangan: json["ruangan"],
        boardId: json["board_id"],
        humidity: json["humidity"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lon": lon,
        "mq2": mq2,
        "temp": temp,
        "name": name,
        "notif": notif,
        "status": status,
        "ruangan": ruangan,
        "board_id": boardId,
        "humidity": humidity,
        "updated_at": updatedAt.toIso8601String(),
      };
}
