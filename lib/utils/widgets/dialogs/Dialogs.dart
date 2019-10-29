import 'package:flutter/material.dart';
import 'package:mysacco/pages/authentication/Login.dart';
import 'package:mysacco/utils/constants/Constants.dart';

class LoadingDialog {
    static void show(BuildContext context, String theContent) {
        showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
                title: new Text(theContent, style: TextStyle(
                    fontFamily: 'IBMPlexSansMedium',
                ),),
                content: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        new LinearProgressIndicator(
                            backgroundColor: Colors.blue[100],
                            valueColor: new AlwaysStoppedAnimation<Color>(Constants.coloredPrimary),
                        ),
                    ],
                ),
            );
        });
    }
}

class TextDialog {
    static void show(BuildContext context, String theTitle, String theBody, String thePositiveButton, String theNegativeButton, Widget thePositiveFunction) {
        showDialog(
                context: context,
                builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                        contentPadding: EdgeInsets.only(bottom: 0, top: 16, left: 24, right: 24),
                        title: new Text(theTitle),
                        content: new Text(theBody, style: TextStyle(color: Colors.grey[600], fontSize: 16, fontFamily: 'IBMPlexSansSemiBold',),),
                        actions: <Widget>[
                            new FlatButton(
                                child: new Text(theNegativeButton, style: TextStyle(color: Constants.coloredPrimary, fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'IBMPlexSansSemiBold',),),
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                            ),
                            thePositiveButton != "" ? new FlatButton(
                                child: new Text(thePositiveButton != "" ? thePositiveButton : theNegativeButton, style: TextStyle(color: Constants.coloredPrimary, fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'IBMPlexSansSemiBold',),),
                                onPressed: () {
                                    if (thePositiveButton == "") {
                                        Navigator.of(context).pop();
                                    } else {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) {
                                                return thePositiveFunction;
                                            },
                                        ));
                                    }
                                },
                            ) : null,
                        ],
                    );
                });
    }

    static void showIfActivationSuccessful(BuildContext theBuildContext, String theTitle, String theBody, String thePositiveButton, String theNegativeButton, String theNextRoute) {
        showDialog(
                context: theBuildContext,
                builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                        contentPadding: EdgeInsets.only(bottom: 0, top: 16, left: 24, right: 24),
                        title: new Text(theTitle),
                        content: new Text(theBody, style: TextStyle(color: Colors.grey[600], fontSize: 16, fontFamily: 'IBMPlexSansSemiBold',),),
                        actions: <Widget>[
                            new FlatButton(
                                child: new Text(thePositiveButton != "" ? thePositiveButton : theNegativeButton, style: TextStyle(color: Constants.coloredPrimary, fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'IBMPlexSansSemiBold',),),
                                onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(theBuildContext).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false,
                                    );
                                    return new Future(() => false);
                                },
                            ),
                        ],
                    );
                });
    }

    static void showWithRedirectToLogin(BuildContext theBuildContext, String theTitle, String theBody, String thePositiveButton) {
        showDialog(
                context: theBuildContext,
                builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                        contentPadding: EdgeInsets.only(bottom: 0, top: 16, left: 24, right: 24),
                        title: new Text(theTitle),
                        content: new Text(theBody, style: TextStyle(color: Colors.grey[600], fontSize: 16, fontFamily: 'IBMPlexSansSemiBold',),),
                        actions: <Widget>[
                            new FlatButton(
                                child: new Text(thePositiveButton, style: TextStyle(color: Constants.coloredPrimary, fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'IBMPlexSansSemiBold',),),
                                onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(theBuildContext).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false,
                                    );
                                    return new Future(() => false);
                                },
                            ),
                        ],
                    );
                });
    }

    static void showIFPINIncorrect(BuildContext theBuildContext, String theTitle, String theBody, String thePositiveButton) {
        showDialog(
                context: theBuildContext,
                builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                        contentPadding: EdgeInsets.only(bottom: 0, top: 16, left: 24, right: 24),
                        title: new Text(theTitle),
                        content: new Text(theBody, style: TextStyle(color: Colors.grey[600], fontSize: 16, fontFamily: 'IBMPlexSansSemiBold',),),
                        actions: <Widget>[
                            new FlatButton(
                                child: new Text(thePositiveButton, style: TextStyle(color: Constants.coloredPrimary, fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'IBMPlexSansSemiBold',),),
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                            ),
                        ],
                    );
                });
    }
}
