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

  //............................................................................

  late GoogleMapController MAP_CONTROLLER;
  Position? CURRENT_POSITION;
  var RECORDED_POSITIONS = Queue<Tuple2<double, double>>();
  Set<Polygon> _POLYGONS_SET = HashSet<Polygon>();

  //............................................................................

  // Called only once when an instance of this class is created
  @override
  void initState() {
    super.initState();
    _initLocationService();
    _POLYGONS_SET.add(globals.MAIN_POLYGON);
  }

  // "Future" not needed as we will not await this function
  void _initLocationService() async {
    var location = locations.Location();

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

    location.onLocationChanged.listen(_onLocationChangedHandler);

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() => CURRENT_POSITION = position); // re-runs the build method

    //var loc = await location.getLocation();
    //print("${loc.latitude} ${loc.longitude}");
  }

  void _onLocationChangedHandler(locations.LocationData loc) {
    // Regulate RECORDED_POSITIONS size
    if (RECORDED_POSITIONS.length >= globals.MAX_RECORDED_POSITIONS_IN_MEMORY) {
      RECORDED_POSITIONS.removeFirst();
    }

    // Save location
    if (loc.latitude != null && loc.longitude != null) {
      RECORDED_POSITIONS.addLast(
          Tuple2<double, double>(loc.latitude!, loc.longitude!));
      print("Just recorded ${loc.latitude} ${loc.longitude} for a total of ${RECORDED_POSITIONS.length}");
    }
  }

  //............................................................................

  // Called automatically when state changes (setState())
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: buildAppBar(),
        // if/else to show that the map is loading until initState() is done
        body: CURRENT_POSITION == null  ? const Text("Loading") : buildGoogleMap(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Maps Sample App'),
      backgroundColor: Colors.green[700],
    );
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController mc) => MAP_CONTROLLER = mc,
      initialCameraPosition: CameraPosition(
        target: LatLng(CURRENT_POSITION!.latitude, CURRENT_POSITION!.longitude),
        zoom: 11.0,
      ),
      myLocationEnabled: true,
      polygons: _POLYGONS_SET,
    );
  }
}