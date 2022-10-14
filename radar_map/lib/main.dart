import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final currentTime = getRadarTime();
      debugPrint(currentTime);
    });
    final currentTime = getRadarTime();
    debugPrint(currentTime);
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  String getRadarTime() {
    var now = DateTime.now();
    now = now.subtract(const Duration(minutes: 10));
    final minute = twoDigits((now.minute / 10).floor() * 10);
    final result =
        "${fourDigits(now.year)}${twoDigits(now.month)}${twoDigits(now.day)}${twoDigits(now.hour)}$minute";
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 492 * 2,
            height: 492 * 2,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-37.96775624991637, 145.25861768465924),
                zoom: 7,
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        'https://server.arcgisonline.com/ArcGIS/rest/services/world_imagery/MapServer/tile/{z}/{y}/{x}',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    //opacity: 0.5,

                    opacity: 1),
                TileLayer(
                  urlTemplate:
                      'https://radar-tiles.service.bom.gov.au/tiles/202210130030/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  opacity: 1,
                  backgroundColor: Colors.transparent,
                ),
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}.png',
                  subdomains: const ["a", "b", "c", "d"],
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  opacity: 1,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
