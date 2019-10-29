import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/utils/menus/Menus.dart';
import 'package:mysacco/utils/storage/Storage.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
    Storage storage;
    PageDetails pageDetails;
    String strMenuTypes;

    Home({Key key, @required this.storage, this.pageDetails,this.strMenuTypes}) : super(key: key);

    @override
    _HomeState createState() => _HomeState(this.storage, this.pageDetails,this.strMenuTypes);
}

int thisIndex = 0;
String strGreetings = "";

class _HomeState extends State<Home> {
    Storage storage;
    PageDetails pageDetails;
    double dblOpacity = 1.0;
    String strDisplayMessage;
    String strMenuTypes;

    _HomeState(this.storage, this.pageDetails,this.strMenuTypes);

    @override
    initState() {
        super.initState();
        strGreetings = fnComposeGreetings();
        strDisplayMessage = storage.SLOGAN;
        if(pageDetails.strPageFrom == Page.MAIN_ACTIVITY){
            fnChangeDisplayText();
        }
        //fnChangeDisplayText();
    }

    String fnComposeGreetings(){
        DateTime now = new DateTime.now();
        var formatter = new DateFormat('HH');
        String formattedDate = formatter.format(now);

        int inHour = int.tryParse(formattedDate);
        String strTimeOfDay;

        if(inHour > 0 && inHour < 12){
            strTimeOfDay = "morning";
        } else if(inHour >= 12 && inHour < 18){
            strTimeOfDay = "afternoon";
        } else if(inHour >= 18 && inHour < 26){
            strTimeOfDay = "evening";
        } else {
            strTimeOfDay = "morning";
        }

        String strName = storage.USER_NAME;
        strName = strName.split(" ")[0];
        String strGreeting = "Good $strTimeOfDay, $strName";
        return strGreeting;
    }

    fnChangeDisplayText() {
        Future.delayed(Duration(seconds: 15), () {
            setState(() {
                strDisplayMessage = strGreetings;
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: ListView(
                children: <Widget>[
                    Padding(
                        padding:
                        const EdgeInsets.only(bottom: 6, top: 14, left: 14, right: 14),
                        child: InkWell(
                            child: Container(
                                child: Card(
                                    elevation: 0.5,
                                    child: Column(
                                        children: <Widget>[
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(0),
                                                child: Container(
                                                    padding: const EdgeInsets.only(
                                                            left: 14, right: 14, bottom: 16, top: 16),
                                                    child: Image.asset(
                                                        "assets/home/org_logo.png",
                                                        height: 80,
                                                        fit: BoxFit.contain,
                                                    ),
                                                ),
                                            ),
                                            SizedBox(width: 16),
                                            Container(
                                                padding: const EdgeInsets.only(bottom: 8, top: 8),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                        border: Border(
                                                                top: BorderSide(
                                                                        color: Theme
                                                                                .of(context)
                                                                                .dividerColor))),
                                                /*child: Text(
                                                    storage.SLOGAN,
                                                    style: TextStyle(
                                                            fontFamily: 'IBMPlexSansSemiBold',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 16,
                                                            color: Colors.blueGrey[600]),
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                ),*/
                                                child: AnimatedOpacity(
                                                    opacity: dblOpacity,
                                                    duration: Duration(seconds: 3),
                                                    child: Text(
                                                        strDisplayMessage,
                                                        style: TextStyle(
                                                                fontFamily: 'IBMPlexSansSemiBold',
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 16,
                                                                color: Colors.blueGrey[600]),
                                                        maxLines: 3,
                                                        textAlign: TextAlign.center,
                                                    ),
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
                        ),
                    ),
                    strMenuTypes == MenuTypes.LIST ? Padding(
                        padding: EdgeInsets.only(left: 14, right: 14, bottom: 8),
                        child: ListView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeMenus == null ? 0 : homeMenus.length,
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
                                                                /*child: Image.asset(
                                                                    homeMenus[index].image,
                                                                    height: 20,
                                                                    width: 20,
                                                                    fit: BoxFit.cover,
                                                                ),*/
                                                                child: Icon(homeMenus[index].icon, color: homeMenus[index].color, size: 22.8,)
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
                                                                            homeMenus[index].title,
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
                                                    PageMetaData metadata = PageMetaData(homeMenus[index].route);
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
                        padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                        child: GridView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeMenus == null ? 0 : homeMenus.length,
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
                                                                color: homeMenus[index].backgroundColor, // button color
                                                                child: InkWell(
                                                                    splashColor: homeMenus[index].backgroundColor, // inkwell color
                                                                    child: SizedBox(width: 48, height: 48, child: Icon(homeMenus[index].icon, color: homeMenus[index].color, size: 24,)),
                                                                ),
                                                            ),
                                                        ),
                                                        /*ClipRRect(
                                                            borderRadius: BorderRadius.circular(0),
                                                            child: Container(
                                                                padding: const EdgeInsets.only(left: 16),
                                                                child: Image.asset(
                                                                    homeMenus[index].image,
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
                                                                            homeMenus[index].title,
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
                                                    PageMetaData metadata = PageMetaData(homeMenus[index].route);
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
