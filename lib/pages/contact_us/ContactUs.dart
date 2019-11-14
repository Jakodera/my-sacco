import 'package:flutter/material.dart';
import 'package:mysacco/data/models/ModelUser.dart';
import 'package:mysacco/utils/configuration/Configuration.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';

class Login extends StatefulWidget {
    @override
    _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
    _LoginState();

    TextEditingController ctPhoneNumber;
    TextEditingController ctPassword;

    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                appBar: InAppTopAppBarForAuth(currentUser.currentSacco),
                body: ListView(children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(top: 48),
                        child: Image.asset(
                            "assets/home/org_logo.png",
                            height: 90,
                            fit: BoxFit.contain,
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
                        child: Text(
                            "Welcome, Please Log In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[500]
                            ),
                        ),
                    ),
                    Container(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
                            child: new Theme(
                                data: new ThemeData(
                                    primaryColor: Constants.coloredDarkPrimary,
                                    primaryColorDark: Constants.coloredPrimary,
                                ),
                                child: new TextField(
                                    obscureText: false,
                                    controller: ctPhoneNumber,
                                    keyboardType: TextInputType.phone,
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: new BorderSide(
                                                        color: Constants.coloredPrimary,
                                                        width: 2,
                                                        style: BorderStyle.solid)),
                                        contentPadding: EdgeInsets.only(left: 0, right: 10, top: 16, bottom: 14),
                                        hintText: "700 123 456",
                                        labelText: "Phone Number",
                                        prefixText: '+' + Configurations.COUNTRY_CODE + ' ',
                                        prefixIcon: Icon(
                                            Icons.call,
                                            color: Colors.blueGrey,
                                        ),
                                    ),
                                ),
                            )),
                    Container(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                            child: new Theme(
                                data: new ThemeData(
                                    primaryColor: Constants.coloredDarkPrimary,
                                    primaryColorDark: Constants.coloredPrimary,
                                ),
                                child: new TextField(
                                    obscureText: true,
                                    controller: ctPassword,
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: new BorderSide(
                                                        color: Constants.coloredPrimary,
                                                        width: 2,
                                                        style: BorderStyle.solid)),
                                        contentPadding:
                                        EdgeInsets
                                                .only(left: 0, right: 10, top: 16, bottom: 14),
                                        hintText: "Enter your PIN",
                                        labelText: "Mobile Banking PIN",
                                        prefixIcon: Icon(
                                            Icons.vpn_key,
                                            color: Colors.blueGrey,
                                        ),
                                    ),
                                ),
                            )),
                    Padding(padding: EdgeInsets.only(bottom: 8),)
                ])
        );
    }
}
