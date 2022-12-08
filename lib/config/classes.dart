import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor:
          isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}
