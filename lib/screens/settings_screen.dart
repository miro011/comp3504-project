import 'package:flutter/material.dart';
import 'package:term_project/config/classes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Settings(),
      debugShowCheckedModeBanner: false,
    );
  }
}

var indexClicked = 3;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                  DrawerTile(
                    index: 0,
                    clickState: indexClicked,
                  ),
                  DrawerTile(
                    index: 1,
                    clickState: indexClicked,
                  ),
                  DrawerTile(
                    index: 2,
                    clickState: indexClicked,
                  ),
                  DrawerTile(
                    index: 3,
                    clickState: indexClicked,
                  ),
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
      body: const Center(child: Text('Settings')),
    );
  }
}