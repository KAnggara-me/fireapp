class Device {
  int? id;
  String? lokasi;
  String? lon;
  String? lat;
  String? humidity;
  String? temp;
  String? status;
  String? notif;
  String? createdAt;
  String? updatedAt;

  Device(
      {this.id,
      this.lokasi,
      this.lon,
      this.lat,
      this.humidity,
      this.temp,
      this.status,
      this.notif,
      this.createdAt,
      this.updatedAt});

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
    lon = json['lon'];
    lat = json['lat'];
    humidity = json['humidity'];
    temp = json['temp'];
    status = json['status'];
    notif = json['notif'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lokasi'] = lokasi;
    data['lon'] = lon;
    data['lat'] = lat;
    data['humidity'] = humidity;
    data['temp'] = temp;
    data['status'] = status;
    data['notif'] = notif;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
