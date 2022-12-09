import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/Globals.dart';
import 'package:term_project/config/classes.dart';

import '../API.dart';

// import '../API.dart';

/*
* Variable that is used in the DrawerTile to highlight what screen is active
* in the navigation drawer*/
var indexClicked = 1;

//High Score Screen
class HighScore extends StatefulWidget {
  const HighScore({Key? key}) : super(key: key);

  @override
  State<HighScore> createState() => _HighScoreState();
}

class _HighScoreState extends State<HighScore> {
  Map<String, int> highscores = {};

  @override
  void initState() {
    API.getHighscores().then((res) {
      developer.log("Fetched highscores: ${res}", name: 'Highscores');
      highscores = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    setState(() {
      highscores.forEach((user, score) {
        developer.log('Adding highscore ${user} @ ${score}');
        children.add(Text("${user} @ ${score}"));
      });
    });

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/bg05.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text('High Score'),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderDrawer(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  //Home
                  DrawerTile(
                    index: 0,
                    clickState: indexClicked,
                  ),
                  //High Score
                  DrawerTile(
                    index: 1,
                    clickState: indexClicked,
                  ),
                  //Map Screen
                  DrawerTile(
                    index: 2,
                    clickState: indexClicked,
                  ),
                  //Settings
                  DrawerTile(
                    index: 3,
                    clickState: indexClicked,
                  ),
                  //About
                  DrawerTile(
                    index: 5,
                    clickState: indexClicked,
                  ),
                  //Exit
                  DrawerTile(
                    index: 4,
                    clickState: indexClicked,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.scoreboard, size: 80),
            title: Text(
              'High Score',
              style: GoogleFonts.acme(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Defaults.naviItemColor,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.score_outlined),
            title: Text('TEsting'),
          )
        ],
      ),
    );
  }
}
