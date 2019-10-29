import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/pages/main_activity/fragments/FragmentHome.dart';
import 'package:mysacco/pages/main_activity/fragments/FragmentLoans.dart';
import 'package:mysacco/pages/main_activity/fragments/FragmentMyAccount.dart';
import 'package:mysacco/pages/main_activity/fragments/FragmentTransact.dart';
import 'package:mysacco/utils/configuration/Configuration.dart';
import 'package:mysacco/utils/menus/Menus.dart';
import 'package:mysacco/utils/storage/Storage.dart';
import 'package:mysacco/utils/widgets/dialogs/Dialogs.dart';
import 'package:xml/xml.dart' as xml;

// ignore: must_be_immutable
class MainActivity extends StatefulWidget {
  Storage storage;
  PageDetails pageDetails;

  MainActivity({Key key, @required this.storage, this.pageDetails})
      : super(key: key);

  @override
  _MainActivityState createState() =>
      _MainActivityState(this.storage, this.pageDetails);
}

bool blStorageLoaded = false;

class _MainActivityState extends State<MainActivity>
    with SingleTickerProviderStateMixin {
  Storage storage;
  PageDetails pageDetails;
  PageDetails pageDetailsForHome = new PageDetails(Page.MAIN_ACTIVITY);
  String strMenuTypes = MenuTypes.LIST;

  _MainActivityState(this.storage, this.pageDetails);

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: choices.length);
    if (pageDetails.strPageFrom == Page.LOGIN) {
      pageDetails = pageDetailsForHome;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: new Text(
              "Sky World SACCO",
              style: new TextStyle(
                fontFamily: 'IBMPlexSansSemiBold',
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: new Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                ),
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              labelStyle: new TextStyle(
                fontFamily: 'IBMPlexSansSemiBold',
              ),
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  //icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(controller: _tabController, children: <Widget>[
            Home(
              storage: storage,
              pageDetails: pageDetails,
              strMenuTypes: strMenuTypes,
            ),
            Transact(storage: storage, strMenuTypes: strMenuTypes),
            MyAccount(storage: storage, strMenuTypes: strMenuTypes),
            Loans(storage: storage, strMenuTypes: strMenuTypes),
          ]),
          drawer: new Drawer(
            child: ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text(
                    storage.USER_NAME,
                    style: new TextStyle(
                      color: Colors.grey[900],
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansSemiBold',
                    ),
                  ),
                  accountEmail: new Text(
                    "+" + storage.PHONE_NUMBER,
                    style: new TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'IBMPlexSansSemiBold',
                    ),
                  ),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image:
                          new ExactAssetImage('assets/home/drawer_paper.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/icons/avatars/current_user.png",
                      height: 48,
                      width: 48,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                new ListTile(
                    leading: Icon(Icons.home),
                    title: new Text(
                      "Home",
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                    ),
                    onTap: () {
                      _tabController.animateTo(0);
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.compare_arrows),
                    title: new Text(
                      "Transact",
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                    ),
                    onTap: () {
                      _tabController.animateTo(1);
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.person),
                    title: new Text(
                      "My Account",
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                    ),
                    onTap: () {
                      _tabController.animateTo(2);
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.date_range),
                    title: new Text(
                      "Loans",
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                    ),
                    onTap: () {
                      _tabController.animateTo(3);
                      Navigator.pop(context);
                    }),
                /*new ListTile(
                                        leading: Icon(Icons.line_style),
                                        title: new Text("Other Services"),
                                        onTap: () {
                                            Navigator.pop(context);
                                        }),*/
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.settings),
                    title: new Text(
                      "Settings",
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.call),
                    title: new Text(
                      "Contacts",
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: new Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                    ),
                    onTap: () {
                      LoadingDialog.show(context, "Please wait");

                      HomeScreenController.fnLogOut(context, storage);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenController {
  static Future fnLogOut(BuildContext theContext, Storage storage) async {
    var dtNow = new DateTime.now();
    String strDateTime = new DateFormat("yyyy-MM-dd HH:mm:ss").format(dtNow);
    var builder = new xml.XmlBuilder();
    //builder.processing("xml", "version='1.0'");
    builder.element("MESSAGES", nest: () {
      builder.attribute("DATETIME", strDateTime);
      builder.attribute("VERSION", Configurations.APP_VERSION);
      builder.element("LOGIN", nest: () {
        builder.attribute("USERNAME", storage.PHONE_NUMBER);
        builder.attribute("PASSWORD", storage.PASSWORD);
        builder.attribute("IMEI", storage.IMEI_NUMBER);
      });
      builder.element("MSG", nest: () {
        builder.attribute("SESSION_ID", storage.IMEI_NUMBER);
        builder.attribute("ORG_ID", Configurations.ORGANIZATION_ID);
        builder.attribute("TYPE", "MOBILE_BANKING");
        builder.attribute("ACTION", "LOGOUT");
        builder.attribute("VERSION", storage.IMEI_NUMBER);
      });
    });
    var strLogoutXML = builder.build().toString();

    FormData formData = new FormData.fromMap({
      "data": strLogoutXML,
    });
    await Dio().post(Configurations.POST_URL, data: formData);

    Navigator.pop(theContext);
    Navigator.of(theContext)
        .pushNamedAndRemoveUntil("/Login", ModalRoute.withName("/Login"));
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'HOME', icon: Icons.home),
  const Choice(title: 'TRANSACT', icon: Icons.compare_arrows),
  const Choice(title: 'MY ACCOUNT', icon: Icons.person),
  const Choice(title: 'LOANS', icon: Icons.attach_money),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        new TextStyle(fontFamily: 'IBMPlexSansSemiBold');
    /*Theme
                .of(context)
                .textTheme
                .display1;*/
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
