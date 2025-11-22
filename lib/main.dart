import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screen/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasPermission = false;

  Future getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        hasPermission = true;
      } else {
        Permission.location.request().then((value) {
          setState(() {
            hasPermission = (value == PermissionStatus.granted);
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arah Kiblat',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Coolvetica',
        scaffoldBackgroundColor: const Color(0xFFD3EFFD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          surface: const Color(0xFFD3EFFD),
        ),
      ),

      home: FutureBuilder(
        future: getPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginPage();
          }
          return const Scaffold(backgroundColor: Colors.black);
        },
      ),
    );
  }
}
