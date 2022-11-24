import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locations;
import 'package:location_platform_interface/location_platform_interface.dart' as lpi;


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position? currentPosition;

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = position;
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    _initLocationService();
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
        body: currentPosition == null
            ? const Text("Loading")
            : GoogleMap(
          // onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                currentPosition!.latitude!, currentPosition!.longitude!),
            zoom: 11.0,
          ),
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
      ),
    );
  }

  Future _initLocationService() async {
    var location = locations.Location();

    location.onLocationChanged.listen((locations.LocationData loc) {
      print("${loc.latitude} ${loc.longitude}");
    });

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == lpi.PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != lpi.PermissionStatus.granted) {
        return;
      }
    }

    var loc = await location.getLocation();
    print("${loc.latitude} ${loc.longitude}");
  }

  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }
}

class MapPainter extends CustomPainter {
  final Map<String, MapLandmark> landmarksMap;
  late Paint p;
  bool debugPaint = false;

  MapPainter(this.landmarksMap) {
    p = Paint()
      ..strokeWidth = 5.0
      ..color = Colors.orange
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (landmarksMap != null && landmarksMap.length > 0) {
      landmarksMap.forEach((id, value) {
        canvas.drawCircle(
            Offset(
                value.screenPoint.x.toDouble(), value.screenPoint.y.toDouble()),
            8,
            p);
      });
    } else {
      canvas.drawCircle(Offset(70, 70), 25, p);
    }
  } //paint()

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MapLandmark {
  Position pos;
  late ScreenPoint screenPoint;

  MapLandmark(this.pos){
    screenPoint = ScreenPoint();
  }
}

class ScreenPoint {
  int x;
  int y;

  ScreenPoint({this.x=0, this.y=0});
}