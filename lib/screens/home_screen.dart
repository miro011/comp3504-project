import 'package:flutter/material.dart';
import 'package:term_project/Globals.dart';
import 'package:term_project/config/classes.dart';

/*
* Variable that is used in the DrawerTile to highlight what screen is active
* in the navigation drawer*/
var indexClicked = 0;

//Home Screen
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        title: const Text('Home'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/background/bg05.png',
                  height: 120.0,
                  fit: BoxFit.fill,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 16),
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, Defaults.navigationRoutes[2]);
                  },
                  label: const Text('Explore!'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
