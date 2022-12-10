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

    final resp = await http
        .get(Uri.parse('http://${globals.API_URL}/holes?deviceID=${devID}'));
    //final resp = await http.get(Uri.parse('http://${globals.API_URL}/holes'));

    if (resp.statusCode != 200) {
      print("Invalid response from API, ${resp.statusCode}:${resp.body}");
    }

    // print("Received response from server, attempting to decode into json");

    var exploredAreas = jsonDecode(resp.body);

    // print("Decoded JSON into ${exploredAreas}");

    DateTime fillerDate = DateTime.utc(2000,1,1,0,0,0);

    exploredAreas.forEach((key, coords) {
      List<LatLng> hole = [
        LatLng(double.parse(coords['coordOneX']), double.parse(coords['coordOneY'])),
        LatLng(double.parse(coords['coordTwoX']), double.parse(coords['coordTwoY'])),
        LatLng(double.parse(coords['coordThreeX']), double.parse(coords['coordThreeY'])),
        LatLng(double.parse(coords['coordFourX']), double.parse(coords['coordFourY'])),
      ];
      // print("Recieved hole ${hole}");
      holes[fillerDate] = hole;
      fillerDate = fillerDate.add(Duration(seconds:1));
    });

    print("Added datetime to ${holes.length} holes");

    return holes;
  }

  /// Add these points to the API
  /// Returns true if it was successful, false otherwise
  static Future<bool> addExplored(Map<DateTime, List<LatLng>> newExplored) async {
    developer.log('Adding explored areas', name: 'API');
    String devID = await getDeviceID();

    Map<String, Map<String, double>> encodableExplored = {};

    newExplored.forEach((dt, holeData) {
      encodableExplored[dt.toString()] = {
        'coordOneX': holeData[0].latitude,
        'coordOneY': holeData[0].longitude,
        'coordTwoX': holeData[1].latitude,
        'coordTwoY': holeData[1].longitude,
        'coordThreeX': holeData[2].latitude,
        'coordThreeY': holeData[2].longitude,
        'coordFourX': holeData[3].latitude,
        'coordFourY': holeData[3].longitude,
      };
    });

    var resp = await http.post(
      Uri.parse('http://${globals.API_URL}/holes?deviceID=${devID}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(encodableExplored),
    );

    if (resp.statusCode != 200) {
      developer.log("Error returned from API when adding explored holes: ${resp.body}", name:'API');
      return Future.value(false);
    }

    return Future.value(true);
  }

  static Future<List> getHighscores() async {
    developer.log('Getting highscores', name: 'API');
    List<String> deviceIDs = [];

    final resp = await http.get(Uri.parse('http://${globals.API_URL}/holes'));

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
