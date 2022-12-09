import 'dart:collection';

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
  List<List<LatLng>> locally_recorded_holes = [];
  List<List<LatLng>> remote_recorded_holes = [];
  Set<Polygon> polygons = HashSet<Polygon>(); // only has one


  // Called only once when an instance of this class is created
  @override
  void initState() {
    super.initState();
    initLocationService();
    polygons.add(globals.MAIN_POLYGON);
    // fetchExplored();

    Future.delayed(const Duration(seconds: 30), () {
      var newHole = calcNewHole(LatLng(51.1129, -114.1089));
      addNewHole(newHole);
      print("Just added a debug hole on nosehill");
    });
  }


  void fetchExplored() {
    API.getExplored().then((res) {
      setState(() {
        print("Successfully fetched holes from API: ${res.length}");
        remote_recorded_holes = res;
      });
    });
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
        print("New hole collides with existing holes, ignoring: ${newHole}");
        return;
      }

      print("New hole does not collide with existing holes, adding: ${newHole}");
      addNewHole(newHole);
  }


  void clearHoles() {
    setState(() {
      polygons.remove(polygons.first);
      assert(polygons.length == 1, "We are drawing more polygons than we should be");
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
    List<List<LatLng>> holes = polygons.first.holes;
    holes.add(hole);

    setState(() {
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

      polygons.add(Polygon(
        polygonId: PolygonId('hole${DateTime.now()}'),
        points: hole,
        fillColor: Colors.green.withOpacity(0.5),

        strokeColor: Colors.black,
        strokeWidth: 0,

        geodesic: true,
      ));
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
