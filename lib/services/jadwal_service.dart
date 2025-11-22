import 'dart:convert';
import 'package:http/http.dart' as http;

class JadwalService {
  static Future<Map<String, dynamic>> getJadwal(String cityCode) async {
    final now = DateTime.now();

    final url = Uri.parse(
      "https://api.myquran.com/v2/sholat/jadwal/$cityCode/${now.year}/${now.month}/${now.day}",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['jadwal'];
    }

    throw Exception("Failed to load jadwal");
  }
}
