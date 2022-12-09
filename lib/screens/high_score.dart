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
  Map scoreCounts = Map();


  @override
  void initState() {
    API.getHighscores().then((res) {

      res.forEach((element) {
        if(!scoreCounts.containsKey(element)) {
          scoreCounts[element] = 1;
        } else {
          scoreCounts[element] += 1;
        }
      });

      print(scoreCounts.length);

      scoreCounts.forEach((key, value) {
        String leadersID = key;
        int leadersScores = value;



        // print('Recieved $leadersID + $leadersScores');
      });

    });
  }

  @override
  Widget build(BuildContext context) {

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
      body: ListView.builder(
        itemCount: scoreCounts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Text("test"),
            trailing: const Text ("test"),
          );
        },
      )
    );
  }
}
