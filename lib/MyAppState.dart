import 'dart:collection';
import 'dart:ffi';
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
  int POLYGON_ID_COUNTER = 2; // 1 being the main one

  //............................................................................

  // Called only once when an instance of this class is created
  @override
  void initState() {
    super.initState();
    _initLocationService();
    //_POLYGONS_SET.add(globals.MAIN_POLYGON);
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
    if (loc.latitude == null || loc.longitude == null) return;
    double lat = loc.latitude ?? 0.0;
    double long = loc.longitude ?? 0.0;

    // remove negative values
    lat += 90;
    long += 180;

    double xMin = long - globals.LIGHT_DISTANCE;
    double xMax = long + globals.LIGHT_DISTANCE;
    double yMin = lat - globals.LIGHT_DISTANCE;
    double yMax = lat + globals.LIGHT_DISTANCE;

    print("********************************************");
    print(xMin.toString() + " " + xMax.toString() + " " + yMin.toString() + " " + yMax.toString());
    print("********************************************");

    for (Polygon poly in _POLYGONS_SET) {
      bool xMatch = false;
      bool yMatch = false;

      double targetXMin = poly.holes[0][1].longitude + 180;
      double targetXMax = poly.holes[0][0].longitude + 180;
      double targetYMin = poly.holes[0][2].latitude + 90;
      double targetYMax = poly.holes[0][0].latitude + 90;

      print("////////////////////////////////////////////");
      print(targetXMin.toString() + " " + targetXMax.toString() + " " + targetYMin.toString() + " " + targetYMax.toString());
      print("////////////////////////////////////////////");

      for (double x in [xMin, xMax]) {
        if (x >= targetXMin && x <= targetXMax) xMatch = true;
      }
      for (double y in [yMin, yMax]) {
        if (y >= targetYMin && y <= targetYMax) yMatch = true;
      }

      if (xMatch == true && yMatch == true) {
        print("............................................");
        print("exists");
        print("............................................");
        return;
      } // collision detected
    }

    addPolygon([[
      LatLng(yMax-90, xMax-180),
      LatLng(yMax-90, xMin-180),
      LatLng(yMin-90, xMax-180),
      LatLng(yMin-90, xMin-180),
    ]]);
  }

  void addPolygon(List<List<LatLng>> holes) {
    _POLYGONS_SET.add(
        Polygon(
          polygonId: PolygonId(POLYGON_ID_COUNTER.toString()),
          points: globals.ENTIRE_MAP_POINTS, // list of points to display polygon
          holes: holes, // draws a hole in the Polygon
          fillColor: Colors.blueGrey.withOpacity(0.8),
          strokeColor: Colors.blueGrey, // border color to polygon
          strokeWidth: 4, // width of border
          geodesic: true,
        )
    );

    POLYGON_ID_COUNTER += 1;

    setState((){}); // re-runs the build method
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