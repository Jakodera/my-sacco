import 'package:flutter/material.dart';
import 'package:mysacco/pages/authentication/Login.dart';
import 'package:mysacco/pages/main_activity/MainActivity.dart';

final Map<String, WidgetBuilder> routes = {
    "/Home": (BuildContext context) => MainActivity(storage: null,),
    "/MyAccount": (BuildContext context) => MainActivity(storage: null,),
    "/Loans": (BuildContext context) => MainActivity(storage: null,),
    "/OtherServices": (BuildContext context) => MainActivity(storage: null,),
    "/Settings": (BuildContext context) => MainActivity(storage: null,),
    "/Login": (BuildContext context) => Login(),
    "/Logout": (BuildContext context) => MainActivity(storage: null,),
    "/ContactUs": (BuildContext context) => MainActivity(storage: null,),
};
