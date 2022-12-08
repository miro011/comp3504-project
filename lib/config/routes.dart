import 'package:flutter/material.dart';
import 'package:term_project/MyApp.dart';
import 'package:term_project/screens/about_screen.dart';
import 'package:term_project/screens/exit_screen.dart';
import 'package:term_project/screens/home_screen.dart';
import 'package:term_project/screens/login_screen.dart';

import '../screens/high_score.dart';
import '../screens/registration_screen.dart';
import '../screens/settings_screen.dart';

/*
* Class to handle navigation in the app. If you want to add more pages to navigate
* just add it to the case below and follow the format.
* To invoke the navigation, use the code Navigator.popAndPushNamed(context, <settings.name>);*/
class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      case "/high_score":
        return MaterialPageRoute(builder: (_) => const HighScore());
      case '/map_screen':
        return MaterialPageRoute(builder: (_) => const MyApp());
      case '/settings_screen':
        return MaterialPageRoute(builder: (_) => const Settings());
      case '/login_screen':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/registration_screen':
        return MaterialPageRoute(builder: (_) => const Registration());
      case '/about_screen':
        return MaterialPageRoute(builder: (_) => const About());
      case '/exit_screen':
        return MaterialPageRoute(builder: (_) => const Exit());
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
            'Sorry page was not found!',
            style: TextStyle(color: Colors.red, fontSize: 18.0),
          ),
        ),
      );
    });
  }
}
