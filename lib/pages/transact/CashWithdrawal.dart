import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:mysacco/data/models/ModelConfirmation.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/data/models/ModelSpinner.dart';
import 'package:mysacco/data/models/ModelUser.dart';
import 'package:mysacco/pages/confirm_transaction/ConfirmTransactionWithPIN.dart';
import 'package:mysacco/pages/main_activity/MainActivity.dart';
import 'package:mysacco/utils/configuration/Configuration.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/data_sanitization/MobileNumbers.dart';
import 'package:mysacco/utils/storage/Storage.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';
import 'package:mysacco/utils/widgets/dialogs/Dialogs.dart';
import 'package:mysacco/utils/widgets/forms/Button.dart';
import 'package:mysacco/utils/widgets/forms/EditText.dart';
import 'package:mysacco/utils/widgets/spinner/Spinner.dart';
import 'package:mysacco/utils/widgets/text/TextSubtitle.dart';
import 'package:mysacco/utils/widgets/text/TextTitle.dart';
import 'package:xml/xml.dart' as xml;

// ignore: must_be_immutable
class CashWithdrawal extends StatefulWidget {
    Storage storage;
    PageMetaData metadata;

    CashWithdrawal({Key key, @required this.storage, @required this.metadata}) : super(key: key);

    @override
    _CashWithdrawalState createState() => _CashWithdrawalState(this.storage, this.metadata);
}

bool blPageLoaded = false;
var storageBox;
bool blSpinnerAccountFromError = false;
bool blSpinnerWithdrawalServiceError = false;

class _CashWithdrawalState extends State<CashWithdrawal> {
    Storage storage;
    PageMetaData metadata;

    _CashWithdrawalState(this.storage, this.metadata);

    String strPageTitle = "Withdraw Money";
    String strPageSubtitle = "Please enter money withdrawal details below";
    String strConfirmationText = "Confirm Cash Withdrawal";
    String strSubmissionXML;

    IconData icAccountFrom = Icons.account_box;
    IconData icWithdrawalService = Icons.language;

    int inRadioButtonIDs = 0;
    bool blMyPhoneNumberSelected;
    final ctAmount = TextEditingController();
    final ctPhoneNumberTo = TextEditingController();
    final GlobalKey<FormState> gkFormKey = GlobalKey<FormState>();
    final GlobalKey<SpinnerState> gkSpinnerAccountFrom = GlobalKey<SpinnerState>();
    final GlobalKey<SecondSpinnerState> gkSpinnerWithdrawalService = GlobalKey<SecondSpinnerState>();

    static List<ModelSpinner> lsAccountFrom = <ModelSpinner>[];
    static List<ModelSpinner> lsWithdrawalService = <ModelSpinner>[];

    String strAccountFrom;
    String strWithdrawalService;
    String strPhoneNumberToOption = "MY_NUMBER";
    String strAmount;
    String strPhoneNumberTo = "";
    Future ftrLoading;

    @override
    void dispose() {
        ctAmount.dispose();
        ctPhoneNumberTo.dispose();
        lsAccountFrom = <ModelSpinner>[];
        lsWithdrawalService = <ModelSpinner>[];
        SpinnerData.mdSpinnerModelValue = null;
        SecondSpinnerData.mdSpinnerModelValue = null;
        ftrLoading = null;
        blSpinnerAccountFromError = false;
        blSpinnerWithdrawalServiceError = false;
        super.dispose();
    }

    void initState() {
        ctPhoneNumberTo.text = "+" + storage.PHONE_NUMBER;
        blPageLoaded = false;

        fnLoadPageMetaData(context, storage);

        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        try {
            return new WillPopScope(
                child: Scaffold(
                        appBar: AppBarWithHomeReplacement(currentUser.currentSacco, storage, new PageDetails(Page.TRANSACTION)),
                        body: Form(
                            key: gkFormKey,
                            child: ListView(children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 16),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        PageTitle(strPageTitle),
                                        Container(
                                                padding: EdgeInsets.only(left: 16, right: 24),
                                                child: SizedBox(
                                                    height: 5,
                                                    width: !blPageLoaded ? 72 : 0,
                                                    child: new LinearProgressIndicator(
                                                        backgroundColor: Colors.blue[100],
                                                        valueColor: new AlwaysStoppedAnimation<Color>(Constants.coloredPrimary),
                                                    ),
                                                )
                                        )
                                    ],
                                ),
                                PageSubtitle(strPageSubtitle),

                                Spinner(key: gkSpinnerAccountFrom, txHint: "Select Account", icPrefixIcon: icAccountFrom, mdSpinnerModel: lsAccountFrom, blError: blSpinnerAccountFromError, strErrorText: "Select the account you are withdrawing from"),

                                SecondSpinner(key: gkSpinnerWithdrawalService, txHint: "Withdrawal Service", icPrefixIcon: icWithdrawalService, mdSecondSpinnerModel: lsWithdrawalService, blError: blSpinnerWithdrawalServiceError, strErrorText: "Select the service you are withdrawing via",),

                                Container(
                                    padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                    child: EditText(
                                        'Enter amount here',
                                        'Amount',
                                        Icons.fiber_smart_record,
                                        suffixText: Configurations.CURRENCY,
                                        validatorText: "Enter the amount you are withdrawing",
                                        keyboardType: TextInputType.number,
                                        isPasswordField: false,
                                        controller: ctAmount,
                                    ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                                    child: new Text(
                                        'Withdraw to:',
                                        style: new TextStyle(
                                                fontFamily: 'IBMPlexSansSemiBold',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.0,
                                                color: Colors.grey[800]),
                                    ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 2, right: 16),
                                    child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                            new Radio(
                                                value: 0,
                                                groupValue: inRadioButtonIDs,
                                                onChanged: fnPhoneNumberToOptionClicked,
                                            ),
                                            new GestureDetector(
                                                onTap: () {
                                                    fnPhoneNumberToOptionClicked(0);
                                                },
                                                child: new Text(
                                                    'MY Phone Number',
                                                    style: new TextStyle(
                                                        fontFamily: 'IBMPlexSansSemiBold',
                                                        fontSize: 15.4,
                                                    ),
                                                ),
                                            ),
                                            new Radio(
                                                value: 1,
                                                groupValue: inRadioButtonIDs,
                                                onChanged: fnPhoneNumberToOptionClicked,
                                            ),
                                            new GestureDetector(
                                                onTap: () {
                                                    fnPhoneNumberToOptionClicked(1);
                                                },
                                                child: new Text(
                                                    'OTHER Number',
                                                    style: new TextStyle(
                                                        fontFamily: 'IBMPlexSansSemiBold',
                                                        fontSize: 15.4,
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                Container(
                                        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                        child: EditText(
                                            '0700 123 456',
                                            'Phone Number To',
                                            Icons.call,
                                            validatorText: "Enter phone number to send money to",
                                            keyboardType: TextInputType.phone,
                                            isPasswordField: false,
                                            controller: ctPhoneNumberTo,
                                            enabled: this.blMyPhoneNumberSelected,
                                        )
                                ),
                                IconedButton(
                                    'WITHDRAW MONEY',
                                            () => fnSubmitData(),
                                    buttonColor: Constants.coloredPrimary,
                                    buttonIcon: Icons.check,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 8),
                                ),
                            ]),
                        )
                ),
                onWillPop: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainActivity(storage: storage, pageDetails: new PageDetails(Page.TRANSACTION))), (Route<dynamic> route) => false,
                    );
                    return new Future(() => false);
                },
            );
        } catch (e, s) {
            print("ERROR ON WIDGET BUILD:\n $e");
            print('STACK TRACE:\n $s');
        }
        return null;
    }

    String fnCreatePageMetadataXML(Storage storage) {
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
                    builder.attribute("ACTION", "GET_WITHDRAWAL_ACCOUNTS_AND_MOBILE_MONEY_SERVICES");
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

            setState(() {
                blPageLoaded = true;
            });

            if (strAction == "CON" && strStatus == "SUCCESS") {
                Iterable itAccounts = xmlDocument.findAllElements('ACCOUNT');
                Iterable itServices = xmlDocument.findAllElements('SERVICE');

                for (var count = 0; count < itAccounts.length; count++) {
                    var strAccountNumber = itAccounts.map((each) => each.getAttribute('NO')).toList()[count];
                    var strAccountName = itAccounts.toList()[count].text;
                    setState(() {
                        lsAccountFrom.add(ModelSpinner(strAccountNumber, strAccountName, ""));
                    });
                }

                for (var count = 0; count < itServices.length; count++) {
                    var strServiceID = itServices.map((each) => each.getAttribute('ID')).toList()[count];
                    var strServiceName = itServices.toList()[count].text;
                    setState(() {
                        lsWithdrawalService.add(ModelSpinner(strServiceID, strServiceName, ""));
                    });
                }
            } else if (strAction == "END") {
                TextDialog.showWithRedirectToLogin(theContext, strTitle, strData, "GO TO LOGIN");
            }
        } catch (e, s) {
            print("ERROR ON META-DATA LOAD:\n $e");
            print('STACK TRACE:\n $s');
        }
    }

    void fnPhoneNumberToOptionClicked(int value) {
        try {
            inRadioButtonIDs = value;
            setState(() {
                switch (inRadioButtonIDs) {
                    case 0:
                        strPhoneNumberToOption = "MY_NUMBER";
                        ctPhoneNumberTo.text = "+" + storage.PHONE_NUMBER;
                        blMyPhoneNumberSelected = false;
                        break;
                    case 1:
                        strPhoneNumberToOption = "OTHER_NUMBER";
                        ctPhoneNumberTo.text = "";
                        blMyPhoneNumberSelected = true;
                        break;
                }
            });
        } catch (e, s) {
            print("ERROR ON PHONE NUMBER LOAD:\n $e");
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
                    builder.element('ACCOUNT_NO', nest: strAccountFrom);
                    builder.element('SERVICE_ID', nest: strWithdrawalService);
                    builder.element('MOBILE_NO', nest: strPhoneNumberTo);
                    builder.element('AMOUNT', nest: strAmount);
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

    void fnSubmitData() {
        try {
            bool blAllFieldsFilled = false;
            setState(() {
                strAmount = ctAmount.text;
                strPhoneNumberTo = MobileNumbers.sanitizePhoneNumber(ctPhoneNumberTo.text);
            });

            String strTitle = strPageTitle;

            if (gkFormKey.currentState.validate()) {
                blAllFieldsFilled = true;
            }

            if (SpinnerData.mdSpinnerModelValue == null) {
                gkSpinnerAccountFrom.currentState.updateErrorStatus(true);

                blAllFieldsFilled = false;
            } else {
                gkSpinnerAccountFrom.currentState.updateErrorStatus(false);
            }

            if (SecondSpinnerData.mdSpinnerModelValue == null) {
                gkSpinnerWithdrawalService.currentState.updateErrorStatus(true);

                blAllFieldsFilled = false;
            } else {
                gkSpinnerWithdrawalService.currentState.updateErrorStatus(false);
            }

            if (blAllFieldsFilled) {
                setState(() {
                    strAccountFrom = SpinnerData.mdSpinnerModelValue.key;
                    strWithdrawalService = SecondSpinnerData.mdSpinnerModelValue.key;
                    strSubmissionXML = fnCreatePageSubmissionXML(storage);
                });

                Column clDescription = Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(
                                    left: 14, right: 14, bottom: 16, top: 16),
                            child: Image.asset(
                                "assets/icons/result_states/question.png",
                                height: 86,
                                fit: BoxFit.contain,
                            ),
                        ),
                        Text(
                            strConfirmationText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'IBMPlexSansSemiBold',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                            ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 8),),
                        /*Table(
                            children: [
                                ConfirmationTable.trBuildTableRow("Amount", Configurations.CURRENCY + " " + strAmount),
                                ConfirmationTable.trBuildTableRow("Account From", SpinnerData.mdSpinnerModelValue.value),
                                ConfirmationTable.trBuildTableRow("To Phone Number", "+" + strPhoneNumberTo),
                                ConfirmationTable.trBuildTableRow("Withdrawal Channel", SecondSpinnerData.mdSpinnerModelValue.value),
                            ],
                            border: TableBorder.all(width: 1, color: Colors.grey[300]),
                        )*/
                        Html(
                            data : "Please confirm withdrawal of <b color='#ff00ff'>"+Configurations.CURRENCY + "</b> <b>" + strAmount+"</b>"+
                            "<br/>From <b>"+SpinnerData.mdSpinnerModelValue.value+"</b> "+
                            "<br/>To <b>+"+strPhoneNumberTo+"</b> via <b>"+SecondSpinnerData.mdSpinnerModelValue.value+"</b>",
                            customTextAlign: (dom.Node node) {
                                return TextAlign.center;
                            },
                            customTextStyle: (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                    switch (node.localName) {
                                        case "b":
                                            return baseStyle.merge(TextStyle(color: Colors.blue[800]));
                                    }
                                }
                                return baseStyle;
                            },
                            defaultTextStyle: TextStyle(
                                fontFamily: 'IBMPlexSansSemiBold',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800]
                            ),
                        ),
                    ],
                );

                Confirmation confirmation = new Confirmation(strTitle, strSubmissionXML, clDescription, storage, metadata);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmationPIN(confirmation: confirmation),
                    ),
                );
            }
        } catch (e, s) {
            print("ERROR ON PASSING TO NEXT PAGE:\n $e");
            print('STACK TRACE:\n $s');
        }
    }
}
