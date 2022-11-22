import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;



  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }



  Position? currentPosition;
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = position;
    });
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
        body: currentPosition == null ? const Text("Loading")
            : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentPosition!.latitude!, currentPosition!.longitude!),
                zoom: 11.0,
              ),
            markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(currentPosition!.latitude!, currentPosition!.longitude!),
                ),
                myLocationEnabled: true,
                // markers: {
                //     Marker(
                //       markerId: const MarkerId("currentLocation"),
                //       position: LatLng(currentPosition!.latitude!, currentPosition!.longitude!),
                //     ),
                // },
      ),
    );
  }
}
