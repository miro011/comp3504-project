import 'package:flutter/material.dart';

import '../routes/routes.dart';

void main() {
  runApp(const NaviScreen());
}

class NaviScreen extends StatelessWidget {
  const NaviScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Globe Travela",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/login_screen',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
