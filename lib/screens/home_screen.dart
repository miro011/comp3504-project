import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/screens/defaults.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

var indexClicked = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Function updateState(int index) {
    return () {
      // setState(() {
      //   indexClicked = index;
      // });
      if (index == 4) {
        SystemNavigator.pop();
      }
      Navigator.pop(context);
      Navigator.pushNamed(context, Defaults.navigationRoutes[index]);
    };
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
        title: const Text('Home'),
      ),
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
                  DrawerTile(
                    index: 0,
                    onTap: () => updateState(0),
                  ),
                  DrawerTile(
                    index: 1,
                    onTap: () => updateState(1),
                  ),
                  DrawerTile(
                    index: 2,
                    onTap: () => updateState(2),
                  ),
                  DrawerTile(
                    index: 3,
                    onTap: () => updateState(3),
                  ),
                  DrawerTile(
                    index: 4,
                    onTap: () => updateState(4),
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

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Defaults.naviItemIcon[index],
        size: 35,
        color: indexClicked == index
            ? Defaults.naviItemSelectedColor
            : Defaults.naviItemColor,
      ),
      title: Text(
        Defaults.naviItemText[index],
        style: GoogleFonts.acme(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: indexClicked == index
              ? Defaults.naviItemSelectedColor
              : Defaults.naviItemColor,
        ),
      ),
      onTap: onTap(),
    );
  }
}
