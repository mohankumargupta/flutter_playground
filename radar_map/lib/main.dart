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
  @override
  void initState() {
    super.initState();
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
                /*
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                */
                TileLayer(
                    urlTemplate:
                        'https://server.arcgisonline.com/ArcGIS/rest/services/world_imagery/MapServer/tile/{z}/{y}/{x}',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    //opacity: 0.5,

                    opacity: 1),
                TileLayer(
                  urlTemplate:
                      'https://radar-tiles.service.bom.gov.au/tiles/202209180530/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example2',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
