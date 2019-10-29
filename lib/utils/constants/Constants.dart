import 'package:flutter/material.dart';

class Constants {
    static String appName = "My SACCO";

    //Colors for theme
    static Color lightPrimary = Color(0xfffcfcff);
    static Color coloredPrimary = Color(0xff1976D2);
    static Color coloredDarkPrimary = Color(0xff1565C0);
    static Color coloredLightPrimary = Color(0xff64B5F6);
    static Color darkPrimary = Colors.black;
    static Color lightAccent = Colors.blueGrey[900];
    static Color coloredAccent = Colors.blueGrey[900];
    static Color darkAccent = Colors.white;
    static Color lightBG = Color(0xfffcfcff);
    static Color coloredBG = Color(0xfffcfcff);
    static Color darkBG = Colors.black;
    static Color badgeColor = Colors.red;
    static Color keypadColor = const Color(0xff4A4A4A);

    static ThemeData lightTheme = ThemeData(
        canvasColor: Colors.white,
        backgroundColor: lightBG,
        primaryColor: lightPrimary,
        accentColor: lightAccent,
        cursorColor: lightAccent,
        textTheme: TextTheme(body2: TextStyle(color: darkBG)),
        scaffoldBackgroundColor: lightBG,
        appBarTheme: AppBarTheme(
            elevation: 0,
            textTheme: TextTheme(
                title: TextStyle(
                    color: darkBG,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                ),
            ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
        ),
    );

    static ThemeData coloredTheme = ThemeData(
        canvasColor: Colors.white,
        backgroundColor: coloredBG,
        primaryColor: coloredPrimary,
        accentColor: coloredAccent,
        cursorColor: coloredAccent,
        textTheme: TextTheme(body2: TextStyle(color: darkBG)),
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: coloredBG,
        appBarTheme: AppBarTheme(
            elevation: 5,
            textTheme: TextTheme(
                title: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                ),
            ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
        ),
    );

    static ThemeData darkTheme = ThemeData(
        canvasColor: Colors.white,
        brightness: Brightness.dark,
        backgroundColor: darkBG,
        primaryColor: darkPrimary,
        accentColor: darkAccent,
        scaffoldBackgroundColor: darkBG,
        cursorColor: darkAccent,
        textTheme: TextTheme(body2: TextStyle(color: lightBG)),
        appBarTheme: AppBarTheme(
            elevation: 0,
            textTheme: TextTheme(
                title: TextStyle(
                    color: lightBG,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                ),
            ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
        ),
    );
}
