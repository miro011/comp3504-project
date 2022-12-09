import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/Globals.dart';
import 'package:term_project/config/classes.dart';
import 'dart:collection';
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
  List<Widget> obj = <Widget>[];
  String leadersID ="";
  String leadersScores ="";
  SplayTreeMap sortedScores = SplayTreeMap();






  @override
  void initState() {
    API.getHighscores().then((res) {
      setState(() {

        res.forEach((element) {
          if (!scoreCounts.containsKey(element)) {
            scoreCounts[element] = 1;
          } else {
            scoreCounts[element] += 1;
          }

          sortedScores = SplayTreeMap.from(
              scoreCounts, (key2, key1) => scoreCounts[key1].compareTo(scoreCounts[key2]));

        });
      });


    });

  }

  @override
  Widget build(BuildContext context) {

    sortedScores.forEach((key, value) {
      leadersID = key;
      leadersScores = value.toString();
      obj.add(
          ListTile(
            leading: Text(leadersID),
            trailing: Text(
              leadersScores,
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
          ));

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
        body: ListView.builder(
          itemCount: sortedScores.length,
          itemBuilder: (BuildContext context, int index) {
            return obj[index];
          }),
    );
  }



}
