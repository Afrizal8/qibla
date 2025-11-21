import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

// smoothing filter
double filteredAngle = 0.0;
const smoothing = 0.15; // Semakin kecil = semakin halus

class _QiblahScreenState extends State<QiblahScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // lebih cepat dan smooth
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFD3EFFD),
        body: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            final qiblahDirection = snapshot.data;

            // raw angle dari library
            final rawAngle = (qiblahDirection!.qiblah * (pi / 180) * -1);

            // smoothing filter
            filteredAngle =
                filteredAngle + (rawAngle - filteredAngle) * smoothing;

            // apply to animation
            animation = Tween(
              begin: begin,
              end: filteredAngle,
            ).animate(_animationController!);

            begin = filteredAngle;
            _animationController!.forward(from: 0);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${qiblahDirection.direction.toInt()}°",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: AnimatedBuilder(
                      animation: animation!,
                      builder: (context, child) => Transform.rotate(
                        angle: animation!.value,
                        child: Image.asset('assets/images/qibla.png'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
