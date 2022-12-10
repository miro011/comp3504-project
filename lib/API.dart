import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locations;
import 'package:location_platform_interface/location_platform_interface.dart'
    as lpi;
import 'package:term_project/Globals.dart' as globals;
import 'package:term_project/MyApp.dart';
import 'package:term_project/config/classes.dart';
import 'package:tuple/tuple.dart';
import 'dart:developer' as developer;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static Future<String> getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }

  /// Return a list of all explored points from the DB.
  /// Throws errors from http.get and jsonDecode.
  static Future<Map<DateTime, List<LatLng>>> getExplored() async {
    String devID = await getDeviceID();
    Map<DateTime, List<LatLng>> holes = {};

    developer.log('Getting explored areas', name: 'API');

    final resp = await http
        .get(Uri.parse('http://${globals.API_URL}/holes?deviceID=${devID}'));
    //final resp = await http.get(Uri.parse('http://${globals.API_URL}/holes'));

    if (resp.statusCode != 200) {
      developer
          .log("Invalid response from API, ${resp.statusCode}:${resp.body}");
    }

    var exploredAreas = jsonDecode(resp.body);

    exploredAreas.forEach((key, coords) {
      List<LatLng> hole = [
        LatLng(coords['coordOneX'], coords['coordOneY']),
        LatLng(coords['coordTwoX'], coords['coordTwoY']),
        LatLng(coords['coordThreeX'], coords['coordThreeY']),
        LatLng(coords['coordFourX'], coords['coordFourY']),
      ];
      print("Recieved hole ${hole}");
      holes[DateTime.utc(2000, 1, 1)] = hole;
    });

    return holes;
  }

  /// Add these points to the API
  /// Returns true if it was successful, false otherwise
  static Future<bool> addExplored(Map<DateTime, List<LatLng>> newExplored) {
    developer.log('Adding explored areas', name: 'API');
    return Future.value(false);
  }

  static Future<List> getHighscores() async {
    developer.log('Getting highscores', name: 'API');
    List<String> deviceIDs = [];

    final resp = await http.get(Uri.parse('http://${globals.API_URL}/holes/'));

    if (resp.statusCode != 200) {
      developer
          .log("Invalid response from API, ${resp.statusCode}:${resp.body}");
    }

    var exploredAreas = jsonDecode(resp.body);

    exploredAreas.forEach((key, value) {
      String deviceID = value['deviceID'];
      deviceIDs.add(value['deviceID']);

      print('Recieved deviceID $deviceID');
    });

    return deviceIDs;

    return Future.value(deviceIDs);
  }

  static Future<int> getExploredCount() {
    developer.log("Getting number of explored points", name: 'API');
    return Future.value(10);
  }
}
