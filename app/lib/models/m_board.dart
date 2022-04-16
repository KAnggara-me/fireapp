import 'dart:convert';

List<BoardModel> boardModelFromJson(String str) =>
    List<BoardModel>.from(json.decode(str).map((x) => BoardModel.fromJson(x)));

String boardModelToJson(List<BoardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoardModel {
  BoardModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.userId,
    required this.temp,
    required this.mq2,
    required this.updatedAt,
  });

  String name;
  int id, userId;
  double lat, lon;
  DateTime updatedAt;
  dynamic temp, mq2;

  factory BoardModel.fromJson(Map<String, dynamic> json) => BoardModel(
        id: json["id"],
        name: json["name"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        userId: json["user_id"],
        temp: json["temp"],
        mq2: json["mq2"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lon": lon,
        "user_id": userId,
        "temp": temp,
        "mq2": mq2,
        "updated_at": updatedAt.toIso8601String(),
      };
}
