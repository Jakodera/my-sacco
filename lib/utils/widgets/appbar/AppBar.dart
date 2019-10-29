import 'package:flutter/material.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/pages/main_activity/MainActivity.dart';
import 'package:mysacco/utils/storage/Storage.dart';

/// The app bar need to be reused in other areas, therefore we can store
/// and import it in other areas of the application

class InAppTopAppBar extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;

  InAppTopAppBar(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
        title: new Text(
          /// the title to be shown
          appBarTitle,
          style: new TextStyle(
            fontFamily: 'IBMPlexSansSemiBold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarWithHomeNavigation extends StatelessWidget
    with PreferredSizeWidget {
  final String appBarTitle;

  AppBarWithHomeNavigation(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil('/Home', ModalRoute.withName('/Home')),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
        title: new Text(
          /// the title to be shown
          appBarTitle,
          style: new TextStyle(
            fontFamily: 'IBMPlexSansSemiBold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarWithHomeReplacement extends StatelessWidget
    with PreferredSizeWidget {
  final String appBarTitle;
  final Storage storage;
  final PageDetails pageDetails;

  AppBarWithHomeReplacement(this.appBarTitle, this.storage, this.pageDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MainActivity(
                      storage: storage,
                      pageDetails: pageDetails,
                    )),
            (Route<dynamic> route) => false,
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
        title: new Text(
          /// the title to be shown
          appBarTitle,
          style: new TextStyle(
            fontFamily: 'IBMPlexSansSemiBold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class InAppTopAppBarForAuth extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;

  InAppTopAppBarForAuth(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return AuthAppBarActions.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                );
              }).toList();
            },
          )
        ],
        title: new Text(
          /// the title to be shown
          appBarTitle,
          style: new TextStyle(
            fontFamily: 'IBMPlexSansSemiBold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void choiceAction(String choice) {
    if (choice == AuthAppBarActions.CONTACT_US) {
      print('Contact US');
    } else if (choice == AuthAppBarActions.EXIT) {
      print('Exit');
    }
  }
}

class AuthAppBarActions {
  static const String CONTACT_US = 'Contact Us';
  static const String EXIT = 'Exit';

  static const List<String> choices = <String>[
    CONTACT_US,
    EXIT,
  ];
}
