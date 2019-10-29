import 'package:flutter/material.dart';
import 'package:mysacco/data/models/ModelConfirmation.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/pages/main_activity/MainActivity.dart';
import 'package:mysacco/utils/menus/Menus.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';

class TransactionResult extends StatefulWidget {
    final Confirmation confirmation;

    TransactionResult({Key key, @required this.confirmation}) : super(key: key);

    @override
    _TransactionResultState createState() => new _TransactionResultState(confirmation);
}

class _TransactionResultState extends State<TransactionResult> {
    Confirmation confirmation;

    _TransactionResultState(this.confirmation);

    List<Menu> lsResultMenus;

    void initState() {
        lsResultMenus = ResultMenuOptions.getMenus(confirmation.metadata.strRoute);
        print('ROUTE: ' + confirmation.metadata.strRoute);
        super.initState();
    }


    @override
    Widget build(BuildContext context) {
        return new WillPopScope(
            child: Scaffold(
                    appBar: AppBarWithHomeReplacement(confirmation.strTitle, confirmation.storage, new PageDetails(Page.RESULT)),
                    body: ListView(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 48),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                    left: 14, right: 14, bottom: 16, top: 16),
                            child: Image.asset(
                                "assets/icons/result_states/success.png",
                                height: 120,
                                fit: BoxFit.contain,
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 16),
                        ),
                        Text(
                            "Transaction Successful",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'IBMPlexSansSemiBold',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                            child: Text(
                                "Your request to withdraw KES 500 was successful, please wait as it is being processed.",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                        fontFamily: 'IBMPlexSansSemiBold',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600]),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 14, right: 14, bottom: 8),
                            child: ListView.builder(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: lsResultMenus == null ? 0 : lsResultMenus.length,
                                itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(bottom: 6, top: 4),
                                        child: InkWell(
                                            child: Container(
                                                child: Card(
                                                    elevation: 0.5,
                                                    child: Row(
                                                        children: <Widget>[
                                                            ClipRRect(
                                                                borderRadius: BorderRadius.circular(0),
                                                                child: Container(
                                                                    padding: const EdgeInsets.only(left: 16, top: 3),
                                                                    /*child: Image.asset(
                                                                        lsResultMenus[index].image,
                                                                        height: 20,
                                                                        width: 20,
                                                                        fit: BoxFit.cover,
                                                                    ),*/
                                                                    child: Icon(lsResultMenus[index].icon, color: lsResultMenus[index].color, size: 22.8,)
                                                                ),
                                                            ),
                                                            SizedBox(width: 16),
                                                            Container(
                                                                height: 56,
                                                                width: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .width - 130,
                                                                child: ListView(
                                                                    primary: false,
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    shrinkWrap: true,
                                                                    children: <Widget>[
                                                                        Container(
                                                                            padding: const EdgeInsets.only(top: 20),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Text(
                                                                                lsResultMenus[index].title,
                                                                                style: TextStyle(
                                                                                    fontFamily: 'IBMPlexSansSemiBold',
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 16,
                                                                                ),
                                                                                maxLines: 1,
                                                                                textAlign: TextAlign.left,
                                                                            ),
                                                                        ),
                                                                        SizedBox(height: 8),
                                                                    ],
                                                                ),
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                                decoration: new BoxDecoration(
                                                    boxShadow: [
                                                        new BoxShadow(
                                                            color: Colors.grey[100],
                                                            blurRadius: 4,
                                                        ),
                                                    ],
                                                    borderRadius: BorderRadius.circular(4),
                                                ),
                                            ),
                                            onTap: () {
                                                if (lsResultMenus[index].route == "HOME") {
                                                    Navigator.of(context).pushAndRemoveUntil(
                                                        MaterialPageRoute(builder: (context) => MainActivity(storage: confirmation.storage, pageDetails: new PageDetails(Page.RESULT),)), (Route<dynamic> route) => false,
                                                    );
                                                } else {
                                                    PageMetaData metadata = PageMetaData(lsResultMenus[index].route);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (BuildContext context) {
                                                            return NavigationMenu.fnGetNavigationRoute(confirmation.storage, metadata);
                                                        }),
                                                    );
                                                }
                                            },
                                        ),
                                    );
                                },
                            ),
                        ),
                    ])
            ),
            onWillPop: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainActivity(storage: confirmation.storage, pageDetails: new PageDetails(Page.RESULT),)), (Route<dynamic> route) => false,
                );
                return new Future(() => false);
            },
        );
    }
}
