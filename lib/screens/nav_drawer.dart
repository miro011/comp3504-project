import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const NaviScreen());
}

class NaviScreen extends StatelessWidget {
  const NaviScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
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
        title: const Text(
          "Dashboard",
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Drawer Header
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/background/bg05.png'),
                ),
              ),
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        AssetImage('assets/images/background/bg05.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Inventory System',
                    style: GoogleFonts.acme(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'COMP3504',
                    style: GoogleFonts.acme(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation list of the Drawer
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              children: const <Widget>[
                Card(
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/background/bg05.png'),
                    ),
                    title: Text('Log In'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/background/bg05.png'),
                    ),
                    title: Text('High Score'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/background/bg05.png'),
                    ),
                    title: Text('Settings'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/background/bg05.png'),
                    ),
                    title: Text('Search Item'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/background/bg05.png'),
                    ),
                    title: Text('App Info'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app_sharp,
                      size: 50,
                      color: Colors.black,
                    ),
                    title: Text('Exit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
