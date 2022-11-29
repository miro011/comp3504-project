import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
        ),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
