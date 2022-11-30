import 'package:flutter/material.dart';
import 'package:term_project/screens/login_screen.dart';
import 'package:term_project/screens/main_screen.dart';

import '../main.dart';
import '../screens/high_score.dart';
import '../screens/registration_screen.dart';
import '../screens/settings_screen.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case "/high_score":
        return MaterialPageRoute(builder: (_) => const HighScoreScreen());
      case '/map_screen':
        return MaterialPageRoute(builder: (_) => const MyApp());
      case '/settings_screen':
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case '/login_screen':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
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
            'Sorry no route was found!',
            style: TextStyle(color: Colors.red, fontSize: 18.0),
          ),
        ),
      );
    });
  }
}
