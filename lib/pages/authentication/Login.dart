import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';
import 'package:mysacco/data/models/ModelActivation.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/data/models/ModelUser.dart';
import 'package:mysacco/pages/authentication/Activation.dart';
import 'package:mysacco/pages/main_activity/MainActivity.dart';
import 'package:mysacco/utils/configuration/Configuration.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/data_sanitization/MobileNumbers.dart';
import 'package:mysacco/utils/storage/Storage.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';
import 'package:mysacco/utils/widgets/dialogs/Dialogs.dart';
import 'package:mysacco/utils/widgets/forms/Button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xml/xml.dart' as xml;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

String strPhoneNumber = "";
String strPassword = "";
String strIMEI = "";

class _LoginState extends State<Login> {
  TextEditingController ctPhoneNumber = TextEditingController();
  TextEditingController ctPassword = TextEditingController();
  Scaffold scfBody;

  GlobalKey<FormState> gkFormKey = GlobalKey<FormState>();
  String strPlatformImei;

  @override
  void initState() {
    super.initState();
    fnVerifyIMEI();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      strPlatformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    } on PlatformException {
      strPlatformImei = '0';
    }
    if (!mounted) return;

    setState(() {
      strIMEI = strPlatformImei;
    });
  }

  @override
  void dispose() {
    ctPhoneNumber.dispose();
    ctPassword.dispose();
    scfBody = null;
    gkFormKey = null;
    strPlatformImei = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      scfBody = Scaffold(
          appBar: InAppTopAppBarForAuth(currentUser.currentSacco),
          body: Form(
              key: gkFormKey,
              child: ListView(children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 48),
                  child: Image.asset(
                    "assets/home/org_logo.png",
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
                  child: Text(
                    "Welcome, Please Log In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'IBMPlexSansSemiBold',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500]),
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Constants.coloredDarkPrimary,
                        primaryColorDark: Constants.coloredPrimary,
                      ),
                      child: new TextFormField(
                        obscureText: false,
                        controller: ctPhoneNumber,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone number';
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

                          hintText: "0700 123 456",
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
                          labelText: "Phone Number",
                          //prefixText: '+' + Configurations.COUNTRY_CODE + ' ',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    )),
                Container(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Constants.coloredDarkPrimary,
                        primaryColorDark: Constants.coloredPrimary,
                      ),
                      child: new TextFormField(
                        obscureText: true,
                        controller: ctPassword,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your mobile banking PIN';
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
                          hintText: "Enter your PIN",
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
                          labelText: "Mobile Banking PIN",
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    )),
                IconedButton(
                  'LOG IN',
                  () => fnLogIn(),
                  buttonColor: Constants.coloredPrimary,
                  buttonIcon: Icons.lock_open,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                )
              ])));
    } on Exception catch (e) {
      print(e);
    }

    return scfBody;
  }

  fnLogIn() async {
    try {
      strPhoneNumber = ctPhoneNumber.text;
      strPassword = ctPassword.text;

      strPhoneNumber = MobileNumbers.sanitizePhoneNumber(strPhoneNumber);

      if (gkFormKey.currentState.validate()) {
        LoadingDialog.show(context, "Please wait");

        String strXML = LoginController.createXML();

        LoginController.makePostRequest(strXML, context);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future fnVerifyIMEI() async {
    PermissionStatus pmCall;
    try {
      if (strIMEI.isEmpty) {
        pmCall = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.phone);
        if (pmCall != PermissionStatus.granted) {
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
        }
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      pmCall = null;
    }
  }

  void makePostRequest(String strXML) {}
}

class LoginController extends State {
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
        builder.attribute("SESSION_ID", "0");
        builder.attribute("ORG_ID", Configurations.ORGANIZATION_ID);
        builder.attribute("TYPE", "MOBILE_BANKING");
        builder.attribute("ACTION", "LOGIN");
        builder.attribute("VERSION", "1");
        builder.element("APP_ID", nest: strPhoneNumber);
      });
    });
    var xmlData = builder.build();

    return xmlData.toString();
  }

  static Future<void> makePostRequest(
      String theXML, BuildContext theBuildContext) async {
    try {
      print('XML: ' + theXML);

      FormData formData = new FormData.from({
        "data": theXML,
      });

      var response = await Dio().post(Configurations.POST_URL, data: formData);

      print("RESPONSE: " + response.toString());

      String strResponseXML = Uri.decodeFull(response.toString()).trim();

      Navigator.pop(theBuildContext);

      var xmlDocument = xml.parse(strResponseXML);
      var strAction = xmlDocument
          .findAllElements('MSG')
          .map((each) => each.getAttribute('ACTION'))
          .toList()[0];
      var strStatus = xmlDocument
          .findAllElements('MSG')
          .map((each) => each.getAttribute('STATUS'))
          .toList()[0];
      var strSessionID = xmlDocument
          .findAllElements('MSG')
          .map((each) => each.getAttribute('SESSION_ID'))
          .toList()[0]
          .toString();
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

      if (strAction == "CHALLENGE_LOGIN") {
        var strActivationDescription = strData.split(":::::")[1];

        ActivationModel activation = new ActivationModel(strPhoneNumber,
            strPassword, strIMEI, strSessionID, strActivationDescription);

        TextDialog.show(
            theBuildContext,
            strTitle.split("@@@@@")[0],
            strData.split(":::::")[0],
            "ACTIVATE",
            "CANCEL",
            Activation(activation: activation));
      } else if (strAction == "CON" && strStatus == "SUCCESS") {
        var strSessionID = xmlDocument
            .findAllElements('MSG')
            .map((each) => each.getAttribute('SESSION_ID'))
            .toList()[0]
            .toString();

        var orgDetails = xmlDocument.findAllElements('ORG_DETAILS');
        var strUserName = strTitle.split("@@@@@")[1];
        var strAppName = orgDetails
            .map((node) => node.findElements('APP_NAME').single.text)
            .toList()[0]
            .toString();
        var strAppVersion = orgDetails
            .map((node) => node.findElements('APP_VERSION').single.text)
            .toList()[0]
            .toString();
        var strAppMaxPasswordAttempts = orgDetails
            .map((node) =>
                node.findElements('APP_MAX_PASSWORD_ATTEMPTS').single.text)
            .toList()[0]
            .toString();
        var strAppFullName = orgDetails
            .map((node) => node.findElements('FULL_NAME').single.text)
            .toList()[0]
            .toString();
        var strAppShortName = orgDetails
            .map((node) => node.findElements('SHORT_NAME').single.text)
            .toList()[0]
            .toString();
        var strAppSlogan = orgDetails
            .map((node) => node.findElements('SLOGAN').single.text)
            .toList()[0]
            .toString();
        var strOrgPhone = orgDetails
            .map((node) => node.findElements('PHONE').single.text)
            .toList()[0]
            .toString();
        var strOrgEmail = orgDetails
            .map((node) => node.findElements('EMAIL').single.text)
            .toList()[0]
            .toString();
        var strOrgAddress = orgDetails
            .map((node) => node.findElements('ADDRESS').single.text)
            .toList()[0]
            .toString();
        var strOrgLogo = orgDetails
            .map((node) => node.findElements('LOGO').single.text)
            .toList()[0]
            .toString();

        Storage storage = new Storage(
            strPhoneNumber,
            strUserName,
            strPassword,
            strIMEI,
            strSessionID,
            strAppName,
            strAppVersion,
            strAppMaxPasswordAttempts,
            strAppFullName,
            strAppShortName,
            strAppSlogan,
            strOrgPhone,
            strOrgEmail,
            strOrgAddress,
            strOrgLogo);

        /*var dir = await getApplicationDocumentsDirectory();
                Hive.init(dir.path);

                var storageBox = await Hive.openBox(Configurations.APP_NAME);

                if(storageBox.isOpen){
                    storageBox.put(StorageKeys.APP_NAME, strAppName);

                    storageBox.put(StorageKeys.PHONE_NUMBER, strPhoneNumber);
                    storageBox.put(StorageKeys.USER_NAME, strUserName);
                    storageBox.put(StorageKeys.PASSWORD, strPassword);
                    storageBox.put(StorageKeys.IMEI_NUMBER, strIMEI);
                    storageBox.put(StorageKeys.SESSION_ID, strSessionID);

                    storageBox.put(StorageKeys.APP_NAME, strAppName);
                    storageBox.put(StorageKeys.APP_VERSION, strAppVersion);
                    storageBox.put(StorageKeys.APP_MAX_PASSWORD_ATTEMPTS, strAppMaxPasswordAttempts);
                    storageBox.put(StorageKeys.FULL_NAME, strAppFullName);
                    storageBox.put(StorageKeys.SHORT_NAME, strAppShortName);
                    storageBox.put(StorageKeys.SLOGAN, strAppSlogan);
                    storageBox.put(StorageKeys.PHONE, strOrgPhone);
                    storageBox.put(StorageKeys.EMAIL, strOrgEmail);
                    storageBox.put(StorageKeys.ADDRESS, strOrgAddress);
                    storageBox.put(StorageKeys.LOGO, strOrgLogo);

                    Navigator.of(theBuildContext).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainActivity()), (Route<dynamic> route) => false,
                    );
                }*/

        Navigator.of(theBuildContext).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MainActivity(
                  storage: storage, pageDetails: new PageDetails(Page.LOGIN))),
          (Route<dynamic> route) => false,
        );
      } else {
        TextDialog.show(theBuildContext, strTitle, strData, "", "CLOSE", null);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }

  @override
  void initState() {
    super.initState();
  }
}
