import 'dart:convert';

List<LogModel> logModelFromJson(String str) =>
    List<LogModel>.from(json.decode(str).map((x) => LogModel.fromJson(x)));

String logModelToJson(List<LogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogModel {
  LogModel({
    required this.id,
    required this.mq2,
    required this.temp,
    required this.notif,
    required this.status,
    required this.ruangan,
    required this.boardId,
    required this.humidity,
    required this.createdAt,
    required this.updatedAt,
  });
  final double temp, humidity;
  final int id, mq2, boardId;
  final dynamic notif, status, ruangan;
  final DateTime createdAt, updatedAt;

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        id: json["id"],
        mq2: json["mq2"],
        temp: json["temp"],
        notif: json["notif"],
        status: json["status"],
        ruangan: json["ruangan"],
        boardId: json["board_id"],
        humidity: json["humidity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mq2": mq2,
        "temp": temp,
        "notif": notif,
        "status": status,
        "ruangan": ruangan,
        "board_id": boardId,
        "humidity": humidity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
