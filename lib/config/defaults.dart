import 'package:flutter/material.dart';

class Defaults {
  static const Color naviItemColor = Colors.blueGrey;
  static const Color naviItemSelectedColor = Colors.cyan;

  /*
  * Item text for the navigation drawer
  * */
  static const naviItemText = [
    'Home',
    'High Score',
    'Map Area',
    'Settings',
    'Exit',
    'Log In',
    'Register',
    'About',
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
    Icons.login,
    Icons.app_registration,
    Icons.info_outline,
  ];

  /*
  * This would be used to navigate between screens by using routing from the
  * routes.dart file
  * */
  static const navigationRoutes = [
    '/', //[0]
    '/high_score', //[1]
    '/map_screen', //[2]
    '/settings_screen', //[3]
    '/exit_screen', //[4]Not really used, but just for consistency.
    '/login_screen', //[5]
    '/registration_screen', //[6]
    '/about_screen', //[7]
  ];
}
