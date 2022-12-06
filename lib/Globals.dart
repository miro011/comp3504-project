import 'package:google_maps_flutter/google_maps_flutter.dart';

const MAX_RECORDED_POSITIONS_IN_MEMORY = 10000;

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