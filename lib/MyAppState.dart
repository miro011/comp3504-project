import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locations;
import 'package:location_platform_interface/location_platform_interface.dart' as lpi;
import 'package:tuple/tuple.dart';

import 'package:term_project/MyApp.dart';
import 'package:term_project/Globals.dart' as globals;

////////////////////////////////////////////////////////////////////////////////

class MyAppState extends State<MyApp> {
  late GoogleMapController MAP_CONTROLLER;
  Position? CURRENT_POSITION;
  var RECORDDED_POSITIONS = Queue<Tuple2<double, double>>();

  void _recordPosition(locations.LocationData loc) {
    if (RECORDDED_POSITIONS.length >= globals.MAX_RECORDED_POSITIONS_IN_MEMORY) {
      RECORDDED_POSITIONS.removeFirst();
    }

    if (loc.latitude != null && loc.longitude != null) {
      RECORDDED_POSITIONS.addLast(
          Tuple2<double, double>(loc.latitude!, loc.longitude!));
      print("Just recorded ${loc.latitude} ${loc.longitude} for a total of ${RECORDDED_POSITIONS.length}");
    }
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      CURRENT_POSITION = position;
    });
  }

  @override
  void initState() {
    //sets camera at current location
    getCurrentLocation();
    _initLocationService();

    super.initState();

    //initialize polygon
    _polygon.add(
        Polygon(
          // given polygonId
          polygonId: PolygonId('1'),
          // initialize the list of points to display polygon
          points: globals.ENTIRE_MAP_POINTS,
          //draws a hole in the Polygon
          holes: globals.CALGARY_POINTS,
          // given color to polygon
          //fillColor: Colors.green,
          fillColor: Colors.blueGrey.withOpacity(0.8),
          // given border color to polygon
          strokeColor: Colors.blueGrey,
          geodesic: true,
          // given width of border
          strokeWidth: 4,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: CURRENT_POSITION == null
            ? const Text("Loading")
            : GoogleMap(
          onMapCreated: (GoogleMapController mc) => MAP_CONTROLLER = mc,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                CURRENT_POSITION!.latitude, CURRENT_POSITION!.longitude),
            zoom: 11.0,
          ),
          myLocationEnabled: true,
          polygons: _polygon,
        ),
      ),
    );
  }

  Future _initLocationService() async {
    var location = locations.Location();

    location.onLocationChanged.listen(_recordPosition);

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

  Set<Polygon> _polygon = HashSet<Polygon>();
}