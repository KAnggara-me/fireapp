// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

List<DeviceModel> deviceModelFromJson(String str) => List<DeviceModel>.from(
    json.decode(str).map((x) => DeviceModel.fromJson(x)));

String deviceModelToJson(List<DeviceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceModel {
  DeviceModel({
    required this.id,
    required this.lokasi,
    required this.lon,
    required this.lat,
    required this.humidity,
    required this.temp,
    required this.status,
    required this.notif,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String lokasi;
  double lon;
  double lat;
  int humidity;
  int temp;
  String status;
  String notif;
  DateTime createdAt;
  DateTime updatedAt;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json["id"],
        lokasi: json["lokasi"],
        lon: json["lon"],
        lat: json["lat"],
        humidity: json["humidity"],
        temp: json["temp"],
        status: json["status"],
        notif: json["notif"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
        "lon": lon,
        "lat": lat,
        "humidity": humidity,
        "temp": temp,
        "status": status,
        "notif": notif,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
