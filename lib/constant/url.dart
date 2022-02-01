import 'package:http/http.dart' as http;

class BaseUrl {
  // static String baseUrl = "https://fireapp.kahosting.my.id/api/";
  static String baseUrl = "http://fire-api.test/api/";
  static String log = baseUrl + "log";
  static String board = baseUrl + "board";
  static String sensor = baseUrl + "sensor";
}

class API {
  static Future getBoardDetail($id) {
    return http.get(Uri.parse(BaseUrl.board + "/" + $id));
  }

  static Uri log = Uri.parse(BaseUrl.log);
  static Uri board = Uri.parse(BaseUrl.board);
  static Uri sensor = Uri.parse(BaseUrl.sensor);
}
