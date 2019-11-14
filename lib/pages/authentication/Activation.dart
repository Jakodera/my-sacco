import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:mysacco/data/models/ModelActivation.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/data/models/ModelUser.dart';
import 'package:mysacco/pages/main_activity/MainActivity.dart';
import 'package:mysacco/utils/configuration/Configuration.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';
import 'package:mysacco/utils/widgets/dialogs/Dialogs.dart';
import 'package:mysacco/utils/widgets/forms/Button.dart';
import 'package:mysacco/utils/widgets/text/TextTitle.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:io';

class Activation extends StatefulWidget {
  final ActivationModel activation;

  Activation({Key key, @required this.activation}) : super(key: key);

  @override
  _ActivationState createState() => new _ActivationState(activation);
}

String strActivationCode = "";
String strPhoneNumber = "";
String strPassword = "";
String strIMEI = "";
String strSessionID = "";

class _ActivationState extends State<Activation> {
  ActivationModel activation;

  _ActivationState(this.activation);

  TextEditingController ctActivationCode = TextEditingController();

  final GlobalKey<FormState> gkFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    strPhoneNumber = activation.strPhoneNumber;
    strPassword = activation.strPassword;
    strIMEI = activation.strIMEI;
    strSessionID = activation.strSessionID;
    super.initState();
  }

  @override
  void dispose() {
    ctActivationCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: InAppTopAppBar(currentUser.currentSacco),
        body: Form(
            key: gkFormKey,
            child: ListView(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              PageTitle("Activate Mobile App"),
              Html(
                data: activation.strActivationDescription,
                //Optional parameters:
                padding: EdgeInsets.all(14),
                backgroundColor: Colors.white70,
                defaultTextStyle: TextStyle(fontSize: 16),

                linkStyle: const TextStyle(
                  fontFamily: 'IBMPlexSansSemiBold',
                  color: Colors.redAccent,
                ),
                onLinkTap: (url) {
                  // open url in a webview
                },
                onImageTap: (src) {
                  // Display the image in large form.
                },
                // ignore: missing_return
                customTextAlign: (dom.Node node) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "p":
                        return TextAlign.justify;
                    }
                  }
                },
                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "p":
                        return baseStyle.merge(TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansSemiBold',
                        ));
                    }
                  }
                  return baseStyle;
                },
              ),
              Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 8),
                  child: new Theme(
                    data: new ThemeData(
                      primaryColor: Constants.coloredDarkPrimary,
                      primaryColorDark: Constants.coloredPrimary,
                    ),
                    child: new TextFormField(
                      obscureText: false,
                      controller: ctActivationCode,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter activation code sent via SMS';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansMedium',
                      ),
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: new BorderSide(
                                color: Constants.coloredPrimary,
                                width: 2,
                                style: BorderStyle.solid)),
                        contentPadding: EdgeInsets.only(
                            left: 0, right: 10, top: 16, bottom: 14),
                        hintText: "Activation Code",
                        prefixStyle: TextStyle(
                          fontFamily: 'IBMPlexSansSemiBold',
                        ),
                        suffixStyle: TextStyle(
                          fontFamily: 'IBMPlexSansSemiBold',
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'IBMPlexSansMedium',
                        ),
                        errorStyle: TextStyle(
                          fontFamily: 'IBMPlexSansMedium',
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'IBMPlexSansMedium',
                        ),
                        counterStyle: TextStyle(
                          fontFamily: 'IBMPlexSansSemiBold',
                        ),
                        helperStyle: TextStyle(
                          fontFamily: 'IBMPlexSansSemiBold',
                        ),
                        labelText: "Activation Code",
                        prefixIcon: Icon(
                          Icons.dialpad,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  )),
              IconedButton(
                'ACTIVATE',
                () => fnActivation(),
                buttonColor: Constants.coloredPrimary,
                buttonIcon: Icons.flag,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
              )
            ])));
  }

  fnActivation() async {
    strActivationCode = ctActivationCode.text;

    if (gkFormKey.currentState.validate()) {
      LoadingDialog.show(context, "Please wait");

      String strXML = ActivationController.createXML();

      ActivationController.makePostRequest(strXML, context);
    }
  }

  Future fnVerifyIMEI() async {
    if (strIMEI.isEmpty) {
      PermissionStatus pmCall = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.phone);
      if (pmCall != PermissionStatus.granted) {
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
      }
    }
  }

  void makePostRequest(String strXML) {}
}

class ActivationController {

  static String createXML() {
    var dtNow = new DateTime.now();
    String strDateTime = new DateFormat("yyyy-MM-dd HH:mm:ss").format(dtNow);
    var builder = new xml.XmlBuilder();
    //builder.processing("xml", "version='1.0'");
    builder.element("MESSAGES", nest: () {
      builder.attribute("DATETIME", strDateTime);
      builder.attribute("VERSION", Configurations.APP_VERSION);
      builder.element("LOGIN", nest: () {
        builder.attribute("USERNAME", strPhoneNumber);
        builder.attribute("PASSWORD", strPassword);
        builder.attribute("IMEI", strIMEI);
      });
      builder.element("MSG", nest: () {
        builder.attribute("SESSION_ID", strSessionID);
        builder.attribute("ORG_ID", Configurations.ORGANIZATION_ID);
        builder.attribute("TYPE", "MOBILE_BANKING");
        builder.attribute("ACTION", "ACTIVATE_MOBILE_APP");
        builder.attribute("VERSION", "1");
        builder.element("ACTIVATION_CODE", nest: strActivationCode);
      });
    });
    var bookshelfXml = builder.build();

    return bookshelfXml.toString();
  }

  static void makePostRequest(
      String theXML, BuildContext theBuildContext) async {
    FormData formData = new FormData.from({
      "data": theXML,
    });

    var response = await Dio().post(Configurations.POST_URL, data: formData);

    Navigator.pop(theBuildContext);

    var strResponseXML = Uri.decodeFull(response.toString()).trim();

    var xmlDocument = xml.parse(strResponseXML);
    var strAction = xmlDocument
        .findAllElements('MSG')
        .map((each) => each.getAttribute('ACTION'))
        .toList()[0];
    var strStatus = xmlDocument
        .findAllElements('MSG')
        .map((each) => each.getAttribute('STATUS'))
        .toList()[0];
    var strTitle = xmlDocument
        .findAllElements('TITLE')
        .map((node) => node.text)
        .toList()[0]
        .toString();
    var strData = xmlDocument
        .findAllElements('DATA')
        .map((node) => node.text)
        .toList()[0]
        .toString();

    if (strStatus == "SUCCESS" && strAction == "CON") {
      TextDialog.showIfActivationSuccessful(
          theBuildContext, strTitle, strData, "LOGIN NOW", "", "/Login");
    } else {
      TextDialog.show(
          theBuildContext,
          strTitle,
          strData,
          "",
          "CLOSE",
          MainActivity(
              storage: null, pageDetails: new PageDetails(Page.LOGIN)));
    }
  }
}
