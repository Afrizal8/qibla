import 'dart:convert';
import 'package:http/http.dart' as http;

class KotaService {
  static Future<String?> getCityCode(String cityName) async {
    final url = Uri.parse("https://api.myquran.com/v2/sholat/kota/semua");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];

      for (var item in data) {
        if (item['lokasi'].toString().toLowerCase().contains(
          cityName.toLowerCase(),
        )) {
          return item['id'].toString();
        }
      }
    }
    return null;
  }
}
