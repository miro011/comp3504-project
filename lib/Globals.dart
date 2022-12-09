import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const MAX_RECORDED_POSITIONS_IN_MEMORY = 10000;
const LIGHT_DISTANCE_X = 0.0005;
const LIGHT_DISTANCE_Y = 0.0003;
const server_location_send_size =
    100; // send locations to the server every 5000 points

const API_URL = "34.105.39.147:81";

List<LatLng> ENTIRE_MAP_POINTS = [
  LatLng(85, 90),
  LatLng(85, 0.1),
  LatLng(85, -90),
  LatLng(85, -179.9),
  LatLng(0, -179.9),
  LatLng(-85, -179.9),
  LatLng(-85, -90),
  LatLng(-85, 0.1),
  LatLng(-85, 90),
  LatLng(-85, 179.9),
  LatLng(0, 179.9),
  LatLng(85, 179.9),
];

// List<List<LatLng>> CALGARY_POINTS = [[
//   LatLng(51.183790624241, -114.2231309845041),
//   LatLng(51.183790624241, -113.86058216181912),
//   LatLng(50.85985482312287, -113.86058216181912),
//   LatLng(50.85985482312287, -114.2231309845041),
// ]];

List<List<LatLng>> DISCOVERED_HOLES = [];

Polygon MAIN_POLYGON = Polygon(
  polygonId: PolygonId('1'),
  points: ENTIRE_MAP_POINTS,
  // list of points to display polygon
  holes: DISCOVERED_HOLES,
  // draws a hole in the Polygon
  fillColor: Colors.blueGrey.withOpacity(0.8),
  strokeColor: Colors.blueGrey,
  // border color to polygon
  strokeWidth: 0,
  // width of border
  geodesic: true,
);

/*
* class to define constant values for navigation*/
class Defaults {
  static const Color naviItemColor = Colors.blueGrey;
  static const Color naviItemSelectedColor = Colors.cyan;

  /*
  * Item text for the navigation drawer
  * */
  static const naviItemText = [
    'Home',
    'High Score',
    'Explore!',
    'Settings',
    'Exit',
    'About',
    'Globe Travela',
  ];

  /*
  * Icons for the navigation drawer
  * */
  static const naviItemIcon = [
    Icons.home,
    Icons.scoreboard,
    Icons.map,
    Icons.settings,
    Icons.exit_to_app,
    Icons.info_outline,
  ];

  /*
  * This would be used to navigate between screens by using Routing class from the
  * routes.dart file
  * */
  static const navigationRoutes = [
    '/', //[0]
    '/high_score', //[1]
    '/map_screen', //[2]
    '/settings_screen', //[3]
    '/exit_screen', //[4]
  ];
}
