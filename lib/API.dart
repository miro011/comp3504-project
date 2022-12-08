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
import 'dart:developer' as developer;

class API {
  /// Return a list of all explored points from the DB.
  ///
  static Future<List<LatLng>> getExplored() {
    developer.log('Getting explored areas', name: 'API');
    return Future
        .delayed(
        Duration(seconds: 2),
            () =>
        [
          LatLng(10.0, 10.0),
          LatLng(11.0, 11.0),
          LatLng(12.0, 12.0),
          LatLng(13.0, 13.0),
          LatLng(14.0, 14.0),
          LatLng(15.0, 15.0),
          LatLng(16.0, 16.0),
          LatLng(17.0, 17.0),
        ]
    );
  }

  /// Add these points to the API
  static Future<bool> addExplored(List<LatLng> newExplored) {
    developer.log('Adding explored areas', name: 'API');
    return Future.value(false);
  }

  static Future<Map<String, int>> getHighscores() {
    developer.log('Getting highscores', name: 'API');
    return Future.value({'User A': 100, 'User B': 200, 'User C': 300});
  }
}