import 'package:flutter/material.dart';
import 'package:mysacco/data/models/ModelConfirmation.dart';
import 'package:mysacco/pages/confirm_transaction/TransactionResult.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/widgets/appbar/AppBar.dart';
import 'package:mysacco/utils/widgets/dialogs/Dialogs.dart';

typedef ActionCallBack = void Function(Key key);
typedef KeyCallBack = void Function(Key key);


class ConfirmationPIN extends StatefulWidget {
    final Confirmation confirmation;

    ConfirmationPIN({Key key, @required this.confirmation}) : super(key: key);

    @override
    _ConfirmationPINState createState() => new _ConfirmationPINState(confirmation);
}

class _ConfirmationPINState extends State<ConfirmationPIN> {
    Confirmation confirmation;

    _ConfirmationPINState(this.confirmation);

    int inPINRetriesRemaining;

    TextEditingController ctPassword;

    int correctScore = 0;
    String strTransactionPhase = "BEFORE";

    var myDropDownEditor = TextEditingController();

    String strPassword;

    Key _sevenKey = Key('seven');
    Key _eightKey = Key('eight');
    Key _nineKey = Key('nine');
    Key _fourKey = Key('four');
    Key _fiveKey = Key('five');
    Key _sixKey = Key('six');
    Key _oneKey = Key('one');
    Key _twoKey = Key('two');
    Key _threeKey = Key('three');
    Key _dotKey = Key('dot');
    Key _zeroKey = Key('zero');
    Key _clearKey = Key('clear');
    Key _allClearKey = Key('allclear');

    var height;
    var width;
    List _currentValues = List();
    double lastValue;
    TextEditingController _textEditingController;
    bool savedLastValue = false;

    void onActionTapped(Key actionKey) {
        setState(() {
            if (_currentValues.isNotEmpty) {
                lastValue = double.parse(convertToString(_currentValues));
            }
        });
    }

    void keySubmit(Key key) {
        strPassword = "";
        _currentValues.forEach((character) => strPassword = '$strPassword$character');
        print("PIN: " + strPassword);

        fnSubmitData();
    }

    void onKeyTapped(Key key) {
        if (savedLastValue == false && lastValue != null) {
            _currentValues.clear();
            savedLastValue = true;
        }
        setState(() {
            if (identical(_sevenKey, key)) {
                _currentValues.add('7');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_eightKey, key)) {
                _currentValues.add('8');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_nineKey, key)) {
                _currentValues.add('9');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_fourKey, key)) {
                _currentValues.add('4');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_fiveKey, key)) {
                _currentValues.add('5');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_sixKey, key)) {
                _currentValues.add('6');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_oneKey, key)) {
                _currentValues.add('1');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_twoKey, key)) {
                _currentValues.add('2');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_threeKey, key)) {
                _currentValues.add('3');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_zeroKey, key)) {
                _currentValues.add('0');
                _textEditingController.text = convertToString(_currentValues);
            } else if (identical(_clearKey, key)) {
                if (_currentValues.length > 0) {
                    _currentValues.removeLast();
                    _textEditingController.text = convertToString(_currentValues);
                }
            } else if (identical(_allClearKey, key)) {
                _currentValues.clear();
                lastValue = null;
                savedLastValue = false;
                _textEditingController.clear();
            }
        });
    }

    String validateDouble(double doubleValue) {
        int value;
        if (doubleValue % 1 == 0) {
            value = doubleValue.toInt();
        } else {
            return doubleValue.toStringAsFixed(1);
        }
        return value.toString();
    }


    String convertToString(List values) {
        String val = '';
        for (int i = 0; i < values.length; i++) {
            val += _currentValues[i];
        }
        return val;
    }

    List convertToList(String value) {
        List list = new List();
        for (int i = 0; i < value.length; i++) {
            list.add(String.fromCharCode(value.codeUnitAt(i)));
        }
        return list;
    }

    void initState() {
        super.initState();
        inPINRetriesRemaining = int.parse(confirmation.storage.APP_MAX_PASSWORD_ATTEMPTS);
        _textEditingController = TextEditingController();
    }

    @override
    Widget build(BuildContext context) {
        width = MediaQuery
                .of(context)
                .size
                .width;
        height = MediaQuery
                .of(context)
                .size
                .height;
        return Scaffold(
            appBar: InAppTopAppBar(confirmation.strTitle),
            body: Column(
                children: <Widget>[
                    Container(
                            padding: EdgeInsets.only(top: 16),
                            alignment: Alignment.topLeft,
                            width: width - 32,
                            height: ((height / 100) * 48) - 56,
                            child: confirmation.tbDescription
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        width: width,
                        height: 50,
                        decoration: new BoxDecoration(
                                color: Color(0xffF1F3F4)
                        ),
                        child: IgnorePointer(
                            child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: TextField(
                                    enabled: true,
                                    autofocus: false,
                                    obscureText: true,
                                    controller: _textEditingController,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Constants.keypadColor,
                                        fontSize: 24,
                                    ),
                                    decoration: InputDecoration.collapsed(
                                            hintText: 'Mobile Banking PIN',
                                            hintStyle: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.grey[400]
                                            )
                                    ),),
                            ),
                        ),
                    ),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: new BoxDecoration(
                                color: Color(0xffffffff),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                buildKeyItem('1', _oneKey),
                                                buildKeyItem('2', _twoKey),
                                                buildKeyItem('3', _threeKey),
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                buildKeyItem('4', _fourKey),
                                                buildKeyItem('5', _fiveKey),
                                                buildKeyItem('6', _sixKey),
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                buildKeyItem('7', _sevenKey),
                                                buildKeyItem('8', _eightKey),
                                                buildKeyItem('9', _nineKey),
                                            ],
                                        ),
                                    ),

                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                KeyItem(
                                                    key: _clearKey,
                                                    child: Icon(
                                                        Icons.backspace,
                                                        size: 30,
                                                        color: Color(0xffEB2026),
                                                    ),
                                                    onKeyTap: onKeyTapped,
                                                ),
                                                /*buildKeyItem('.', _dotKey),*/
                                                buildKeyItem('0', _zeroKey),
                                                KeyItem(
                                                    key: _dotKey,
                                                    child: ClipOval(
                                                        child: Material(
                                                            color: Constants.coloredPrimary, // button color
                                                            child: InkWell(
                                                                splashColor: Constants.coloredPrimary, // inkwell color
                                                                child: SizedBox(width: 32, height: 32, child: Icon(Icons.check, color: Colors.white, size: 24,)),
                                                            ),
                                                        ),
                                                    ),
                                                    onKeyTap: keySubmit,
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    )
                ],
            ),
        );
    }

    void fnPostTransaction() {
        setState(() {
            Future.delayed(const Duration(milliseconds: 3000), () {
                setState(() {
                    strTransactionPhase = "AFTER";
                });
            });
            strTransactionPhase = "DURING";
        });
    }

    KeyItem buildKeyItem(String val, Key key) {
        return KeyItem(
            key: key,
            child: Text(
                val,
                style: TextStyle(
                    color: Constants.keypadColor,
                    fontStyle: FontStyle.normal,
                    fontSize: 32,
                ),
            ),
            onKeyTap: onKeyTapped,
        );
    }

    void fnSubmitData() {
        if (strPassword != "") {
            if (strPassword == confirmation.storage.PASSWORD) {
                LoadingDialog.show(context, "Please wait");
                print('XML: ' + confirmation.strXML);

                fnSubmitXMLAndReadResponse();
            } else {
                inPINRetriesRemaining = inPINRetriesRemaining - 1;
                if (inPINRetriesRemaining <= 0) {
                    TextDialog.showWithRedirectToLogin(context, "Incorrect PIN!", "You have entered an incorrect PIN too many times, You will be redirected to the login page!", "CLOSE");
                } else {
                    String strEntriesText = "entries";
                    if (inPINRetriesRemaining == 1) {
                        strEntriesText = "entry";
                    }
                    TextDialog.showIFPINIncorrect(context, "Incorrect PIN!", "You have entered an incorrect PIN, please enter a correct PIN and try again!\nYou have " + inPINRetriesRemaining.toString() + " " + strEntriesText + " remaining", "CLOSE");
                }
            }
        } else {
            TextDialog.showIFPINIncorrect(context, "Enter your PIN!", "Please enter your mobile banking PIN to proceed", "CLOSE");
        }
    }

    void fnSubmitXMLAndReadResponse() {
        Future.delayed(const Duration(milliseconds: 3000), () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionResult(confirmation: confirmation),
                ),
            );
        });
    }
}

class KeyItem extends StatelessWidget {
    final Widget child;
    final Key key;
    final KeyCallBack onKeyTap;

    KeyItem({@required this.child, this.key, this.onKeyTap});

    @override
    Widget build(BuildContext context) {
        assert(debugCheckHasMaterial(context));
        return Expanded(
            child: Material(
                type: MaterialType.transparency,
                child: InkResponse(
                    radius: 32,
                    /*splashColor: Constants.coloredPrimary,
                    highlightColor: Colors.white,*/
                    onTap: () => onKeyTap(key),
                    child: Container(
                        //color: Colors.white,
                        alignment: Alignment.center,
                        child: child,
                    ),
                ),
            ),
        );
    }
}

