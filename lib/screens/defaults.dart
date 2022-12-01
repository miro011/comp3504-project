import 'package:flutter/material.dart';

class Defaults {
  static const Color naviItemColor = Colors.blueGrey;
  static const Color naviItemSelectedColor = Colors.cyan;

  static const naviItemText = [
    'Home',
    'High Score',
    'Map Area',
    'Settings',
    'Exit',
    'Log In',
    'Register',
  ];

  static const naviItemIcon = [
    Icons.home,
    Icons.scoreboard,
    Icons.map,
    Icons.settings,
    Icons.exit_to_app,
    Icons.login,
    Icons.app_registration,
  ];

  static const navigationRoutes = [
    '/',
    '/high_score',
    '/map_screen',
    '/settings_screen',
    '/login_screen',
    '/registration_screen',
  ];
}
