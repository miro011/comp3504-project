import 'package:flutter/material.dart';

class HighScoreScreen extends StatelessWidget {
  const HighScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HighScore(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HighScore extends StatefulWidget {
  const HighScore({Key? key}) : super(key: key);

  @override
  State<HighScore> createState() => _HighScoreState();
}

class _HighScoreState extends State<HighScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "High Scores",
        ),
      ),
      body: const Center(
        child: Text('High Scores'),
      ),
    );
  }
}
