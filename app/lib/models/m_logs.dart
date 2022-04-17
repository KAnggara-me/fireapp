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
    required this.ruangan,
    required this.boardId,
    required this.createdAt,
    required this.updatedAt,
  });
  final int id, mq2, boardId;
  dynamic notif, ruangan, temp;
  final DateTime createdAt, updatedAt;

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        id: json["id"],
        mq2: json["mq2"],
        temp: json["temp"],
        notif: json["notif"],
        ruangan: json["ruangan"],
        boardId: json["board_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mq2": mq2,
        "temp": temp,
        "notif": notif,
        "ruangan": ruangan,
        "board_id": boardId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
