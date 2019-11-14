import 'package:flutter/material.dart';
import 'package:mysacco/data/models/ModelConfirmation.dart';
import 'package:mysacco/data/models/ModelUser.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';
import 'package:mysacco/utils/widgets/forms/Button.dart';
import 'package:mysacco/utils/widgets/text/TextTitle.dart';

class ConfirmTransaction extends StatefulWidget {
    final Confirmation confirmation;

    ConfirmTransaction({Key key, @required this.confirmation}) : super(key: key);

    @override
    _ConfirmTransactionState createState() => new _ConfirmTransactionState(confirmation);
}

class _ConfirmTransactionState extends State<ConfirmTransaction> {
    Confirmation confirmation;

    _ConfirmTransactionState(this.confirmation);

    TextEditingController ctPassword;

    int correctScore = 0;
    String strTransactionPhase = "BEFORE";

    var myDropDownEditor = TextEditingController();

    void initState() {
        super.initState();
    }

    @override
    // ignore: missing_return
    Widget build(BuildContext context) {
        if (strTransactionPhase == "BEFORE") {
            return Scaffold(
                    appBar: InAppTopAppBar(currentUser.currentSacco),
                    body: ListView(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 16),
                        ),
                        PageTitle(confirmation.strTitle),
                        Container(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 0),
                            child: Text(
                                confirmation.strDescription,
                                style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                            child: Text(
                                "Please enter your mobile banking PIN below to confirm this transaction",
                                style: new TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[500]),
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
                                        obscureText: true,
                                        controller: ctPassword,
                                        keyboardType: TextInputType.phone,
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
                                                Icons.security,
                                                color: Colors.blueGrey,
                                            ),
                                        ),
                                    ),
                                )),
                        IconedButton(
                            'CONFIRM TRANSACTION',
                                    () => fnPostTransaction(),
                            buttonColor: Constants.coloredPrimary,
                            buttonIcon: Icons.flag,
                        )
                    ])
            );
        } else if (strTransactionPhase == "DURING") {
            return new WillPopScope(
                child: Scaffold(
                        appBar: AppBarWithHomeNavigation(currentUser.currentSacco),
                        body: ListView(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 16),
                            ),
                            PageTitle("Please Wait Shortly"),
                            Container(
                                padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 0),
                                child: Text(
                                    confirmation.strDescription,
                                    style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                                child: Text(
                                    "Kindly wait shortly as we confirm and perform your transaction.",
                                    style: new TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[500]),
                                ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
                                child: SizedBox(
                                        height: 5,
                                        width: double.infinity,
                                        child: new LinearProgressIndicator(backgroundColor: Colors.blue[100], valueColor: new AlwaysStoppedAnimation<Color>(Constants.coloredPrimary),)),),
                        ])
                ),
                onWillPop: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/Home', ModalRoute.withName('/Home'));
                    return new Future(() => false);
                },
            );
        } else if (strTransactionPhase == "AFTER") {
            return new WillPopScope(
                child: Scaffold(
                        appBar: AppBarWithHomeNavigation(currentUser.currentSacco),
                        body: ListView(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 16),
                            ),
                            PageTitle("Transaction Successful"),
                            Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                                child: Text(
                                    "Your withdrawal of KES 500 was successful",
                                    style: new TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800]),
                                ),
                            ),
                            IconedButton(
                                'CLOSE THIS',
                                        () => fnPostTransaction(),
                                buttonColor: Constants.coloredPrimary,
                                buttonIcon: Icons.close,
                            )
                        ])
                ),
                onWillPop: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/Home', ModalRoute.withName('/Home'));
                    return new Future(() => false);
                },
            );
        }
    }

    void fnPostTransaction() {
        setState(() {
            Future.delayed(const Duration(milliseconds: 3000), () {
                setState(() {
                    strTransactionPhase = "AFTER";
                });
            });
            strTransactionPhase = "DURING";
        });
    }
}
