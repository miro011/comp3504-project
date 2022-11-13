import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  //final LatLng _center = const LatLng(51.0447, 114.0719);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //get devices current location
  LocationData? currentLocation;
  void getCurrentLocation () {
    Location location = Location();

    location.getLocation().then(
          (location) {
            currentLocation = location;
    },
    );
    print(currentLocation);
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: currentLocation == null ? const Text("Loading")
            : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 11.0,
              ),
            markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                ),
            },

          ),
      ),
    );
  }
}
