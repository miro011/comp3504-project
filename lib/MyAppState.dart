import 'dart:collection';
import 'dart:core';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locations;
import 'package:location_platform_interface/location_platform_interface.dart'
    as lpi;
import 'package:term_project/Globals.dart' as globals;
import 'package:term_project/MyApp.dart';
import 'package:term_project/config/classes.dart';
import 'package:tuple/tuple.dart';

import 'API.dart';

var indexClicked = 2;

class MyAppState extends State<MyApp> {
  late GoogleMapController MAP_CONTROLLER;
  Position? CURRENT_POSITION;
  Map<DateTime, List<LatLng>> local_holes = {};
  Map<DateTime, List<LatLng>> remote_holes = {};
  Set<Polygon> polygons = HashSet<Polygon>(); // only has one

  // Called only once when an instance of this class is created
  @override
  void initState() {
    super.initState();
    initLocationService();
    API.getDeviceID().then((deviceID) => print('Running on ${deviceID}'));
  }

  Future<bool> fetchExplored() async {
    try {
      var res = await API.getExplored();
      remote_holes = res;
      recreateHoles();
      return true;
    } catch(err) {
      print("API crashed when fetching explored areas from server: ${err}");
      return false;
    }
  }

  void initLocationService() async {
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

    polygons.add(globals.MAIN_POLYGON);
    await fetchExplored();

    location.onLocationChanged.listen(onLocationChanged);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      CURRENT_POSITION = position;
    }); // re-runs the build method
  }

  bool holeColides(List<LatLng> newHole) {
    for (List<LatLng> holeData in polygons.first.holes) {
      bool xMatch = false;
      bool yMatch = false;

      double targetXMin = holeData[0].longitude;
      double targetXMax = holeData[1].longitude;
      double targetYMax = holeData[2].latitude;
      double targetYMin = holeData[0].latitude;

      for (double x in [newHole[0].longitude, newHole[1].longitude]) {
        if (x >= targetXMin && x <= targetXMax) xMatch = true;
      }
      for (double y in [newHole[0].latitude, newHole[2].latitude]) {
        if (y >= targetYMin && y <= targetYMax) yMatch = true;
      }

      if (xMatch == true && yMatch == true) {
        return true;
      } // collision detected
    }
    return false;
  }

  List<LatLng> calcNewHole(LatLng loc) {
    double xMin = loc.longitude - globals.LIGHT_DISTANCE_X;
    double xMax = loc.longitude + globals.LIGHT_DISTANCE_X;
    double yMin = loc.latitude - globals.LIGHT_DISTANCE_Y;
    double yMax = loc.latitude + globals.LIGHT_DISTANCE_Y;

    return [
      LatLng(yMin, xMin), // top left
      LatLng(yMin, xMax), // top right
      LatLng(yMax, xMax), // bottom right
      LatLng(yMax, xMin), // bottom left
    ];
  }

  void onLocationChanged(locations.LocationData loc) {
    if (loc == null || loc.latitude == null || loc.longitude == null) {
      print("Received a null location, ignoring");
      return;
    }

    List<LatLng> newHole = calcNewHole(LatLng(loc.latitude!, loc.longitude!));

    if (holeColides(newHole)) {
      // print("New hole collides with existing holes, ignoring: ${newHole}");
      return;
    }

    // print("New hole does not collide with existing holes, adding: ${newHole}");
    addNewHole(newHole);
    local_holes[DateTime.now()] = newHole;

    uploadCachedHoles();
  }

  void uploadCachedHoles() {
    if (local_holes.length > globals.server_location_send_size) {
      print("Sending cached holes to the server");
      API.addExplored(local_holes).then((res) {
        if (res) {
          print(
              "Received confirmation on sent holes from the server, clearing local cache");
          setState(() {
            local_holes = {};
            fetchExplored();
          });
        } else {
          print("Received error from server, sticking to locally cached holes");
        }
      }).catchError((e) {
        print("Error sending holes to server? ${e}");
      });
    } else {
      print("Not sending to server as we only have ${local_holes.length}");
    }
  }

  void recreateHoles() {
    print("Recreating all holes after a server refresh");
    clearHoles();
    local_holes.forEach((dt, hole) {
      addNewHole(hole);
    });
    remote_holes.forEach((dt, hole) {
      addNewHole(hole);
    });
  }

  void clearHoles() {
    setState(() {
      while (polygons.length > 1) {
        print(
            "We are drawing more polygons than we should be... there are ${polygons.length} instead of 1");
        polygons.remove(polygons.first);
      }

      polygons.remove(polygons.first);
      polygons.add(Polygon(
        polygonId: PolygonId('global_polygon'),
        points: globals.ENTIRE_MAP_POINTS,
        // list of points to display polygon
        // draws a hole in the Polygon
        fillColor: Colors.blueGrey.withOpacity(0.8),
        strokeColor: Colors.blueGrey,
        // border color to polygon
        strokeWidth: 0,
        // width of border
        geodesic: true,
      ));
    });
  }

// given the new hole it redoes the entire polygon so that it shows up in google maps
  void addNewHole(List<LatLng> hole) {
    // need to use the from to make a copy of the list. Otherwise sometimes we get
    // an immutable version of the list.
    List<List<LatLng>> holes = List<List<LatLng>>.from(polygons.first.holes);
    holes.add(hole);

    setState(() {
      while (polygons.length > 1) {
        print(
            "We are drawing more polygons than we should be... there are ${polygons.length} instead of 1");
        polygons.remove(polygons.first);
      }

      polygons.remove(polygons.first);
      polygons.add(Polygon(
        polygonId: PolygonId('global_polygon${DateTime.now()}'),
        points: globals.ENTIRE_MAP_POINTS,
        holes: holes,
        fillColor: Colors.blueGrey.withOpacity(0.8),

        // Border
        strokeColor: Colors.blueGrey,
        strokeWidth: 0,

        geodesic: true,
      ));

      // polygons.add(Polygon(
      //   polygonId: PolygonId('hole${DateTime.now()}'),
      //   points: hole,
      //   fillColor: Colors.green.withOpacity(0.5),
      //   strokeColor: Colors.black,
      //   strokeWidth: 0,
      //   geodesic: true,
      // ));
    });
  }

// Called automatically when state changes (setState())
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/bg05.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text('Explore!'),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderDrawer(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  //Home
                  DrawerTile(
                    index: 0,
                    clickState: indexClicked,
                  ),
                  //High Score
                  DrawerTile(
                    index: 1,
                    clickState: indexClicked,
                  ),
                  //Map Screen
                  DrawerTile(
                    index: 2,
                    clickState: indexClicked,
                  ),
                  //Settings
                  DrawerTile(
                    index: 3,
                    clickState: indexClicked,
                  ),
                  //Exit
                  DrawerTile(
                    index: 4,
                    clickState: indexClicked,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // if/else to show that the map is loading until initState() is done
      body: CURRENT_POSITION == null
          ? const Center(child: Text("Loading"))
          : buildGoogleMap(),
    );
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController mc) => MAP_CONTROLLER = mc,
      initialCameraPosition: CameraPosition(
        target: LatLng(CURRENT_POSITION!.latitude, CURRENT_POSITION!.longitude),
        zoom: 15.0,
      ),
      myLocationEnabled: true,
      polygons: polygons,
    );
  }
}
