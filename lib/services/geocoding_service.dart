import 'package:geocoding/geocoding.dart';

class GeoCodingService {
  static Future<String> getCityName(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    if (placemarks.isNotEmpty) {
      final city = placemarks.first.subAdministrativeArea;
      return city ?? "Unknown";
    } else {
      return "Unknown";
    }
  }
}
