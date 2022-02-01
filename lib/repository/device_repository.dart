import 'dart:convert';
import 'package:fire_app/constant/url.dart';
import 'package:fire_app/models/device.dart';
import 'package:http/http.dart' as http;

class DeviceRepository {
  Future<List<Device>> fetchDevice() async {
    List<Device> devices = [];
    await http.get(API.board).then((response) {
      if (response.statusCode == 200) {
        Iterable it = json.decode(response.body);
        devices = it.map((e) => Device.fromJson(e)).toList();
        var jsonResponse = json.decode(response.body);
        for (var item in jsonResponse) {
          Device device = Device.fromJson(item);
          devices.add(device);
        }
      }
    });
    return devices;
  }
}
