import 'package:http/http.dart' as http;

class BaseUrl {
  static String baseUrl = "https://fireapp.kahosting.my.id/api/";
  static String log = baseUrl + "log";
  static String login = baseUrl + "auth";
  static String board = baseUrl + "board";
  static String sensor = baseUrl + "sensor";
  static String setting = baseUrl + "setting";
  static String register = baseUrl + "register";
  static String image = "https://source.unsplash.com/600x600/?men";
}

class WA {
  // For help
  static String waUrl = "https://wa.me/";
  static String getHelp(String number, String message) {
    return waUrl + number + "/?text=${Uri.parse(message)}";
  }
}

class API {
  static Future getBoardDetail($id) {
    return http.get(Uri.parse(BaseUrl.board + "/" + $id));
  }

  static Future getSensorById($id) {
    return http.get(Uri.parse(BaseUrl.sensor + "/" + $id));
  }

  static Future delSensorById($id) {
    return http.delete(Uri.parse(BaseUrl.sensor + "/" + $id));
  }

  static Future getAllSensor() {
    return http.get(Uri.parse(BaseUrl.sensor));
  }

  static Future getAllLog() {
    return http.get(Uri.parse(BaseUrl.log));
  }

  static Future getLogById($id) {
    return http.get(Uri.parse(BaseUrl.log + "/" + $id));
  }

  static Map<String, String>? headers = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
  };

  static Uri login = Uri.parse(BaseUrl.login);
  static Uri board = Uri.parse(BaseUrl.board);
  static Uri sensor = Uri.parse(BaseUrl.sensor);
  static Uri setting = Uri.parse(BaseUrl.setting);
  static Uri register = Uri.parse(BaseUrl.register);
  static String token = "9tm3EwzD";
}
