import 'package:flutter/material.dart';
import 'package:term_project/config/routes.dart';
/*
* This is the file that is the root for my code.
* Change the initialRoute to any of the following to set the default screen the app loads
* '/' - loads the home_screen.dart file
* '/high_score' - loads the high_score.dart file
* '/map_screen' - loads the main_screen.dart file <= currently loaded as default
* '/settings_screen' - loads the settings_screen.dart file
*
* Note that this two is not fully implemented on the navigation drawer yet, but can be added later.
* '/login_screen' - loads the login_screen.dart file
* '/registration_screen' - loads the registration_screen.dart file  */

void main() {
  runApp(const Navi());
}

class Navi extends StatelessWidget {
  const Navi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/map_screen',
      onGenerateRoute: Routing.generateRoute,
    );
  }
}
