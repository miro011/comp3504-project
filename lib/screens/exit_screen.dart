import 'package:flutter/material.dart';

var indexClicked = 4;

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
