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
  double humidity, temp;
  DateTime createdAt, updatedAt;
  dynamic ruangan, status, notif;

  factory BoardDetailModel.fromJson(Map<String, dynamic> json) =>
      BoardDetailModel(
        id: json["id"],
        ruangan: json["ruangan"],
        humidity: json["humidity"],
        status: json["status"],
        notif: json["notif"],
        temp: json["temp"],
        boardId: json["board_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ruangan": ruangan,
        "humidity": humidity,
        "status": status,
        "notif": notif,
        "temp": temp,
        "board_id": boardId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
