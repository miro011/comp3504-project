import 'package:flutter/material.dart';

/*
* Variable that is used in the DrawerTile to highlight what screen is active
* in the navigation drawer*/
var indexClicked = 4;

/*
* Screen to load while the app closes if and when there is too many screens
* on the stack to pop.*/

class Exit extends StatefulWidget {
  const Exit({Key? key}) : super(key: key);

  @override
  State<Exit> createState() => _ExitState();
}

class _ExitState extends State<Exit> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Exiting... Please Wait')),
    );
  }
}
