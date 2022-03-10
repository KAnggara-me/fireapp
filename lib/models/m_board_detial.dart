import 'dart:convert';

List<BoardDetailModel> boardDetailModelFromJson(String str) =>
    List<BoardDetailModel>.from(
        json.decode(str).map((x) => BoardDetailModel.fromJson(x)));

String boardDetailModelToJson(List<BoardDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoardDetailModel {
  BoardDetailModel({
    required this.id,
    required this.temp,
    required this.notif,
    required this.status,
    required this.ruangan,
    required this.boardId,
    required this.humidity,
    required this.createdAt,
    required this.updatedAt,
  });

  int id, boardId;
  DateTime createdAt, updatedAt;
  dynamic ruangan, status, notif, humidity, temp;

  factory BoardDetailModel.fromJson(Map<String, dynamic> json) =>
      BoardDetailModel(
        id: json["id"],
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
