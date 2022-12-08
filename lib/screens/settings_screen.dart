import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:term_project/Globals.dart';
import 'package:term_project/config/classes.dart';

/*
* Variable that is used in the DrawerTile to highlight what screen is active
* in the navigation drawer*/
var indexClicked = 3;

//Settings Screen
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool valopt1 = false;
  bool valopt2 = false;

  onToggle1(bool newValue1) {
    setState(() {
      valopt1 = newValue1;
    });
  }

  onToggle2(bool newValue2) {
    setState(() {
      valopt2 = newValue2;
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
        title: const Text('Settings'),
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
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              buildToggleOption('Dark Mode', valopt1, onToggle1),
              buildToggleOption('Notification', valopt2, onToggle2),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAboutDialog(
            context: context,
            applicationIcon: const FlutterLogo(),
            applicationName: 'Globe Travela',
            applicationVersion: '1.0.0',
            applicationLegalese: 'Developed by Trance Mirenzo',
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(15), child: Text("Miroslav Nikolov")),
              const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Terrence Plunkett")),
              const Padding(
                  padding: EdgeInsets.all(15), child: Text("Travis Tkachyk")),
              const Padding(
                  padding: EdgeInsets.all(15), child: Text("Lorenzo Young")),
            ],
          );
        },
        label: const Text('About'),
        icon: const Icon(Icons.info),
        backgroundColor: Defaults.naviItemColor,
      ),
    );
  }
}
