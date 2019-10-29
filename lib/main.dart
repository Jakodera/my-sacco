import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysacco/pages/splash_screen/SplashScreen.dart';
import 'package:mysacco/utils/constants/Constants.dart';

import 'routes/Routes.dart';

void main() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .then((_) {
        runApp(MyApp());
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Constants.coloredPrimary, // navigation bar color
        statusBarColor: Constants.coloredDarkPrimary, // status bar color
    ));
}

class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
    void initState() {
        super.initState();
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Constants.coloredDarkPrimary,
            statusBarIconBrightness: Brightness.light,
        ));
    }

    ThemeData currentTheme() {
        return Constants.coloredTheme;
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constants.appName,
            theme: currentTheme(),
            home: SplashScreen(),
            routes: routes,
        );
    }
}
