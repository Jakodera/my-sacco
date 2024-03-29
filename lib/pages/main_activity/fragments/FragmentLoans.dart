import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/utils/menus/Menus.dart';
import 'package:mysacco/utils/storage/Storage.dart';
import 'package:mysacco/utils/widgets/text/TextTopBar.dart';

// ignore: must_be_immutable
class Loans extends StatefulWidget {
    Storage storage;
    String strMenuTypes;

    Loans({Key key, @required this.storage, this.strMenuTypes}) : super(key: key);

    @override
    _LoansState createState() => _LoansState(this.storage, this.strMenuTypes);
}

class _LoansState extends State<Loans> {
    Storage storage;
    String strMenuTypes;

    _LoansState(this.storage, this.strMenuTypes);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: ListView(
                children: <Widget>[
                    TopBar("Loans"),
                    strMenuTypes == MenuTypes.LIST ? Padding(
                        padding: EdgeInsets.only(left: 14, right: 14, bottom: 8, top: 6),
                        child: ListView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: loansMenus == null ? 0 : loansMenus.length,
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
                                                                padding: const EdgeInsets.only(left: 16, top: 2),
                                                                child: Icon(loansMenus[index].icon, color: loansMenus[index].color, size: 22.8,)
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
                                                                            loansMenus[index].title,
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
                                            decoration: new BoxDecoration(boxShadow: [
                                                new BoxShadow(
                                                    color: Colors.grey[100],
                                                    blurRadius: 4,
                                                ),
                                            ]),
                                        ),
                                        onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                    PageMetaData metadata = PageMetaData(loansMenus[index].route);
                                                    return NavigationMenu.fnGetNavigationRoute(storage, metadata);
                                                },
                                            ));
                                        },
                                    ),
                                );
                            },
                        ),
                    )
                            :

                    Padding(
                        padding: EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
                        child: GridView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: loansMenus == null ? 0 : loansMenus.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 0, top: 0),
                                    child: InkWell(
                                        child: Container(
                                            child: Card(
                                                elevation: 0.5,
                                                child: Column(
                                                    children: <Widget>[
                                                        Padding(padding: EdgeInsets.only(top: 14),),
                                                        ClipOval(
                                                            child: Material(
                                                                color: loansMenus[index].backgroundColor, // button color
                                                                child: InkWell(
                                                                    splashColor: loansMenus[index].backgroundColor, // inkwell color
                                                                    child: SizedBox(width: 48, height: 48, child: Icon(loansMenus[index].icon, color: loansMenus[index].color, size: 24,)),
                                                                ),
                                                            ),
                                                        ),
                                                        /*ClipRRect(
                                                            borderRadius: BorderRadius.circular(0),
                                                            child: Container(
                                                                padding: const EdgeInsets.only(left: 16),
                                                                child: Image.asset(
                                                                    loansMenus[index].image,
                                                                    height: 20,
                                                                    width: 20,
                                                                    fit: BoxFit.cover,
                                                                ),
                                                            ),
                                                        ),*/
                                                        Container(
                                                            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                                                            child: ListView(
                                                                primary: false,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                shrinkWrap: true,
                                                                children: <Widget>[
                                                                    Container(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                            loansMenus[index].title,
                                                                            style: TextStyle(
                                                                                fontFamily: 'IBMPlexSansSemiBold',
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.grey[800],
                                                                                fontSize: 15,
                                                                            ),
                                                                            textAlign: TextAlign.center,
                                                                        ),
                                                                    ),
                                                                    SizedBox(height: 8),
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                            decoration: new BoxDecoration(boxShadow: [
                                                new BoxShadow(
                                                    color: Colors.grey[100],
                                                    blurRadius: 4,
                                                ),
                                            ]),
                                        ),
                                        onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                    PageMetaData metadata = PageMetaData(loansMenus[index].route);
                                                    return NavigationMenu.fnGetNavigationRoute(storage, metadata);
                                                },
                                            ));
                                        },
                                    ),
                                );
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}
