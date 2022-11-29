import 'package:flutter/material.dart';
import 'package:term_project/screens/home_screen.dart';
import 'package:term_project/screens/login_screen.dart';

import '../screens/high_score.dart';
import '../screens/registration_screen.dart';
import '../screens/settings_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/login_screen':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/settings_screen':
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case '/high_score':
        return MaterialPageRoute(builder: (_) => const HighScoreScreen());
      case '/registration_screen':
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Route'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Sorry no router was found!',
            style: TextStyle(color: Colors.red, fontSize: 18.0),
          ),
        ),
      );
    });
  }
}
