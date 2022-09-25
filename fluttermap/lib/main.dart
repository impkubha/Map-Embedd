import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:latlong2/latlong.dart';
import 'package:proj4dart/proj4dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyFlutterMap(),
    );
  }
}

class MyFlutterMap extends StatefulWidget {
  const MyFlutterMap({super.key});

  @override
  State<MyFlutterMap> createState() => _MyFlutterMapState();
}

class _MyFlutterMapState extends State<MyFlutterMap> {
  LatLng point = LatLng(27.4291, 85.0301);
  var location = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (tapPosition, p) {
              // location = await Geocoder2.getDataFromCoordinates(
              //   latitude: p.latitude,
              //   longitude: p.longitude,
              //   googleMapApiKey: "Google-Map-API-key",
              // );
              setState(() {
                point = p;
              });
            },
            center: point,
            zoom: 10.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ["a", "b", "c", "d"],
            ),
            MarkerLayer(
              markers: [
                Marker(
                    height: 100.0,
                    width: 100.0,
                    point: point,
                    builder: (context) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ))
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 16.0),
          child: Column(
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Search for Location",
                      contentPadding: EdgeInsets.all(16.0)),
                ),
              ),
              // Card(
              //   child: Padding(
              //     padding: EdgeInsets.all(16.0),
              //     child: Text(
              //       "${location.first.countryName}",
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // )
            ],
          ),
        )
      ],
    );
  }
}
