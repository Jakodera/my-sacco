import 'package:flutter/material.dart';
import 'package:mysacco/pages/authentication/Login.dart';
import 'package:mysacco/utils/constants/Constants.dart';

class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    Future ftlLoading;
    Scaffold scfBody;

    @override
    void dispose() {
        ftlLoading = null;
        scfBody = null;
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        try {
            ftlLoading = Future.delayed(const Duration(milliseconds: 3000), () {
                ftlLoading = null;
                scfBody = null;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false,
                );
            });

            scfBody = Scaffold(
                body: new Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Container(
                                padding: const EdgeInsets.only(
                                        left: 14, right: 14, bottom: 16, top: 16),
                                child: Image.asset(
                                    "assets/home/org_logo.png",
                                    height: 90,
                                    fit: BoxFit.contain,
                                ),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 24),
                                child: SizedBox(
                                        height: 5,
                                        width: 100,
                                        child: new LinearProgressIndicator(backgroundColor: Colors
                                                .blue[100], valueColor: new AlwaysStoppedAnimation<
                                                Color>(Constants.coloredPrimary),)),),
                        ],
                    ),
                ),
            );
        } on Exception catch (e) {
            debugPrint(e.toString());
        }

        return scfBody;
    }
}