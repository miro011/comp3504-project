import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/Globals.dart';

/*
* Make sure you import this dart file if you want to reuse the classes coded here
* on another dart file*/

/*
* Class to render the header part of the navigation drawer*/
class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
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
            radius: 40,
            foregroundImage: AssetImage('assets/images/icons/app_icon.png'),
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
    );
  }
}

/*
* Class to render the navigation drawer items which allows the user to navigate
* between screens in the app. It takes the indexClicked variable declared on each
* screen as well as the index variable that is used to reference the arraylists
* found in defaults.dart
*/
class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.index,
    required this.clickState,
  }) : super(key: key);

  final int index;
  final int clickState;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Defaults.naviItemIcon[index],
        size: 35,
        color: clickState == index
            ? Defaults.naviItemSelectedColor
            : Defaults.naviItemColor,
      ),
      title: Text(
        Defaults.naviItemText[index],
        style: GoogleFonts.acme(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: clickState == index
              ? Defaults.naviItemSelectedColor
              : Defaults.naviItemColor,
        ),
      ),
      onTap: () {
        if (index == 4) {
          SystemNavigator.pop();
        }
        if (index == 5) {
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
        }
        // Navigator.pop(context);
        //Moved to the next screen selected by user, it takes the index variable
        //to reference the arraylist navigationRoutes[] in defaults.dart
        Navigator.popAndPushNamed(context, Defaults.navigationRoutes[index]);
      },
    );
  }
}

Padding buildToggleOption(String title, bool value, Function onChangeMethod) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.acme(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Defaults.naviItemColor,
            )),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeColor: Defaults.naviItemSelectedColor,
            trackColor: Colors.grey,
            value: value,
            onChanged: (bool newValue) {
              onChangeMethod(newValue);
            },
          ),
        )
      ],
    ),
  );
}

GestureDetector accountSetting(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title,
                style: GoogleFonts.acme(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("null"),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"))
              ],
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.acme(
              fontSize: 20,
              color: Defaults.naviItemColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Icon(Icons.arrow_forward,
              color: Defaults.naviItemSelectedColor),
        ],
      ),
    ),
  );
}
