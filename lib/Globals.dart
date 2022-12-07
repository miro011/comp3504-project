import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as locations;

const MAX_RECORDED_POSITIONS_IN_MEMORY = 10000;
const LIGHT_DISTANCE = 0.0005;

List<LatLng> ENTIRE_MAP_POINTS = [
  LatLng(85, 90), LatLng(85, 0.1),
  LatLng(85, -90), LatLng(85, -179.9),
  LatLng(0, -179.9), LatLng(-85, -179.9),
  LatLng(-85, -90), LatLng(-85, 0.1),
  LatLng(-85, 90), LatLng(-85, 179.9),
  LatLng(0, 179.9), LatLng(85, 179.9),
];

List<List<LatLng>> CALGARY_POINTS = [[
  LatLng(51.183790624241, -114.2231309845041),
  LatLng(51.183790624241, -113.86058216181912),
  LatLng(50.85985482312287, -113.86058216181912),
  LatLng(50.85985482312287, -114.2231309845041),
]];

Polygon MAIN_POLYGON = Polygon(
  polygonId: PolygonId('1'),
  points: ENTIRE_MAP_POINTS, // list of points to display polygon
  //holes: CALGARY_POINTS, // draws a hole in the Polygon
  fillColor: Colors.blueGrey.withOpacity(0.8),
  strokeColor: Colors.blueGrey, // border color to polygon
  strokeWidth: 4, // width of border
  geodesic: true,
);