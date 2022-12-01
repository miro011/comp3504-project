import 'package:flutter/material.dart';
import 'package:term_project/routes/routes.dart';

void main() {
  runApp(const Navi());
}

class Navi extends StatelessWidget {
  const Navi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: Routing.generateRoute,
    );
  }
}
