import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  Map<String, dynamic>? prayerTimes;
  String? city = "Bandung";

  @override
  void initState() {
    super.initState();
    loadPrayerTimes();
  }

  Future<void> loadPrayerTimes() async {
    try {
      // Ambil lokasi
      Position pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      double lat = pos.latitude;
      double lng = pos.longitude;

      // Request ke AlAdhan API
      final uri = Uri.parse(
        "https://api.aladhan.com/v1/timings?latitude=$lat&longitude=$lng&method=99",
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          prayerTimes = data["data"]["timings"];
          loading = false;
        });
      } else {
        setState(() => loading = false);
        debugPrint("AlAdhan API response error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => loading = false);
      debugPrint("Error fetch AlAdhan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jadwal Salat – $city"), centerTitle: true),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : (prayerTimes == null
                ? const Center(child: Text("Gagal memuat jadwal"))
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: prayerTimes!.entries.map((entry) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(entry.key),
                          trailing: Text(entry.value.toString()),
                        ),
                      );
                    }).toList(),
                  )),
    );
  }
}
