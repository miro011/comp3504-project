import 'package:flutter/material.dart';
import 'package:term_project/config/classes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

var indexClicked = 5;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        title: const Text('Log In'),
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
      body: const Center(child: Text('Log In')),
    );
  }
}