import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/screens/defaults.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

var indexClicked = 3;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pages = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Map Area'),
    ),
    const Center(
      child: Text('High Score'),
    ),
    const Center(
      child: Text('Settings'),
    ),
    const Center(
      child: Text('Exit'),
    ),
    const Center(
      child: Text('Log In'),
    ),
    const Center(
      child: Text('Register'),
    ),
  ];

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
      body: pages[indexClicked],
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/background/bg05.png'),
                ),
              ),
              padding: const EdgeInsets.all(0),
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CircleAvatar(
                      radius: 40,
                      foregroundImage:
                          AssetImage('assets/images/icons/app_icon.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Globe Travela',
                      style: GoogleFonts.acme(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(
                      Defaults.naviItemIcon[0],
                      size: 35,
                      color: indexClicked == 0
                          ? Defaults.naviItemSelectedColor
                          : Defaults.naviItemColor,
                    ),
                    title: Text(
                      Defaults.naviItemText[0],
                      style: GoogleFonts.acme(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: indexClicked == 0
                            ? Defaults.naviItemSelectedColor
                            : Defaults.naviItemColor,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Defaults.naviItemIcon[1],
                      size: 35,
                      color: indexClicked == 1
                          ? Defaults.naviItemSelectedColor
                          : Defaults.naviItemColor,
                    ),
                    title: Text(
                      Defaults.naviItemText[1],
                      style: GoogleFonts.acme(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: indexClicked == 1
                            ? Defaults.naviItemSelectedColor
                            : Defaults.naviItemColor,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Defaults.naviItemIcon[2],
                      size: 35,
                      color: indexClicked == 2
                          ? Defaults.naviItemSelectedColor
                          : Defaults.naviItemColor,
                    ),
                    title: Text(
                      Defaults.naviItemText[2],
                      style: GoogleFonts.acme(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: indexClicked == 2
                            ? Defaults.naviItemSelectedColor
                            : Defaults.naviItemColor,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Defaults.naviItemIcon[3],
                      size: 35,
                      color: indexClicked == 3
                          ? Defaults.naviItemSelectedColor
                          : Defaults.naviItemColor,
                    ),
                    title: Text(
                      Defaults.naviItemText[3],
                      style: GoogleFonts.acme(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: indexClicked == 3
                            ? Defaults.naviItemSelectedColor
                            : Defaults.naviItemColor,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Defaults.naviItemIcon[4],
                      size: 35,
                      color: indexClicked == 4
                          ? Defaults.naviItemSelectedColor
                          : Defaults.naviItemColor,
                    ),
                    title: Text(
                      Defaults.naviItemText[4],
                      style: GoogleFonts.acme(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: indexClicked == 4
                            ? Defaults.naviItemSelectedColor
                            : Defaults.naviItemColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
