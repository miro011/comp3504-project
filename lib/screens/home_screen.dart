import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/Globals.dart';
import 'package:term_project/MyApp.dart';
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
        title: Text(Defaults.naviItemText[6]),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/icons/app_icon/App Icon BG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 350),
                  GifView.asset(
                    'assets/images/transparent-boy.gif',
                    height: 200,
                    width: 200,
                    frameRate: 15, // default is 15 FPS
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Go Explore!",
                    style: GoogleFonts.acme(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 240,
                      height: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/background/bg05.png"),
                              fit: BoxFit.cover)),
                      child: Text(
                        "Let's Go Explore!",
                        style: GoogleFonts.acme(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Defaults.naviItemSelectedColor),
                      ), // button text
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
