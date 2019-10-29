import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysacco/utils/widgets/dialogs/Dialogs.dart';
import 'package:xml/xml.dart' as xml;
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/data/models/ModelUser.dart';
import 'package:mysacco/utils/configuration/Configuration.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/storage/Storage.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';
import 'package:mysacco/utils/widgets/forms/Button.dart';

class AccountStatement extends StatefulWidget {
  Storage storage;
  PageMetaData metaData;
  String strSubmissionXML;
  
  @override
  _AccountStatementState createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InAppTopAppBar(currentUser.currentSacco),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0),
          
          ),
          IconedButton('Statement', ()=> fnSubmitData(),
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountList())),
          buttonColor: Constants.coloredPrimary,
          buttonIcon: Icons.check,
          ),
        ],
      ),
      
    );
    
  }
}


fnCreatePageMetadataXML(Storage storage) {
        try {
            DateTime dtNow = new DateTime.now();
            String strDateTime = new DateFormat("yyyy-MM-dd HH:mm:ss").format(dtNow);
            xml.XmlBuilder builder = new xml.XmlBuilder();
            builder.processing("xml", "version='1.0'");
            builder.element("MESSAGES", nest: () {
                builder.attribute("DATETIME", strDateTime);
                builder.attribute("VERSION", Configurations.APP_VERSION);
                builder.element("LOGIN", nest: () {
                    builder.attribute("USERNAME", storage.PHONE_NUMBER);
                    builder.attribute("PASSWORD", storage.PASSWORD);
                    builder.attribute("IMEI", storage.IMEI_NUMBER);
                });
                builder.element("MSG", nest: () {
                    builder.attribute("SESSION_ID", storage.SESSION_ID);
                    builder.attribute("ORG_ID", Configurations.ORGANIZATION_ID);
                    builder.attribute("TYPE", "MOBILE_BANKING");
                    builder.attribute("ACTION", "ACCOUNT_STATEMENT");
                    builder.attribute("VERSION", Configurations.APP_MSG_VERSION);
                });
            });

            xml.XmlNode xmlData = builder.build();

            return xmlData.toString();
        } catch (e, s) {
            print("ERROR ON PAGE META-DATA XML GENERATION:\n $e");
            print('STACK TRACE:\n $s');
        }
        return null;
    }

    Future<void> fnLoadPageMetaData(BuildContext theContext, Storage storage) async {
        try {
            String strXML = fnCreatePageMetadataXML(storage);

            FormData formData = new FormData.fromMap({
                "data": strXML,
            });

            var response = await Dio().post(Configurations.POST_URL, data: formData);

            String strResponseXML = Uri.decodeFull(response.toString()).trim();

            var xmlDocument = xml.parse(strResponseXML);

            var strAction = xmlDocument.findAllElements('MSG').map((each) => each.getAttribute('ACTION')).toList()[0];
            var strStatus = xmlDocument.findAllElements('MSG').map((each) => each.getAttribute('STATUS')).toList()[0];

            var strTitle = xmlDocument.findAllElements('TITLE').map((node) => node.text).toList()[0].toString();
            var strData = xmlDocument.findAllElements('DATA').map((node) => node.text).toList()[0].toString();

                if (strAction == "CON" && strStatus == "SUCCESS") {
                Iterable itAccounts = xmlDocument.findAllElements('ACCOUNT');

                for (var count = 0; count < itAccounts.length; count++) {
                    var strAccountNumber = itAccounts.map((each) => each.getAttribute('NO')).toList()[count];
                    var strAccountName = itAccounts.toList()[count].text;

                    for (var count = 0; count < itAccounts.length; count++) {
                    var strAccountNumber = itAccounts.map((each) => each.getAttribute('NO')).toList()[count];
                    var strAccountName = itAccounts.toList()[count].text;
                   
                }

                }

            } else if (strAction == "END") {
                TextDialog.showWithRedirectToLogin(theContext, strTitle, strData, "GO TO LOGIN");
            }

        } catch (e, s) {
            print("ERROR ON META-DATA LOAD:\n $e");
            print('STACK TRACE:\n $s');
        }
    }

        String fnCreatePageSubmissionXML(Storage storage) {
        try {
            DateTime dtNow = new DateTime.now();
            String strDateTime = new DateFormat("yyyy-MM-dd HH:mm:ss").format(dtNow);
            xml.XmlBuilder builder = new xml.XmlBuilder();
            builder.processing("xml", "version='1.0'");
            builder.element("MESSAGES", nest: () {
                builder.attribute("DATETIME", strDateTime);
                builder.attribute("VERSION", Configurations.APP_VERSION);
                builder.element("LOGIN", nest: () {
                    builder.attribute("USERNAME", storage.PHONE_NUMBER);
                    builder.attribute("PASSWORD", storage.PASSWORD);
                    builder.attribute("IMEI", storage.IMEI_NUMBER);
                });
                builder.element("MSG", nest: () {
                    builder.attribute("SESSION_ID", storage.SESSION_ID);
                    builder.attribute("ORG_ID", Configurations.ORGANIZATION_ID);
                    builder.attribute("TYPE", "MOBILE_BANKING");
                    builder.attribute("ACTION", "WITHDRAW_MONEY");
                    builder.attribute("VERSION", Configurations.APP_MSG_VERSION);
                    builder.element('ACCOUNT_NO', nest: 5000000516000);
                  
                });
            });

            xml.XmlNode xmlData = builder.build();

            return xmlData.toString();
        } catch (e, s) {
            print("ERROR ON PAGE SUBMISSION XML GENERATION:\n $e");
            print('STACK TRACE:\n $s');
        }
        return null;
    }

    fnSubmitData(){
      
    }
