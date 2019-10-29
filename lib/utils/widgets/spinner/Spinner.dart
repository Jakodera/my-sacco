import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysacco/data/models/ModelSpinner.dart';

class Spinner extends StatefulWidget {
    Spinner({Key key, this.txHint, this.icPrefixIcon, this.mdSpinnerModel, this.blError, this.strErrorText}) : super(key: key);

    final String txHint;
    final IconData icPrefixIcon;
    final List<ModelSpinner> mdSpinnerModel;
    final bool blError;
    final String strErrorText;

    @override
    SpinnerState createState() => new SpinnerState(this.txHint, this.icPrefixIcon, this.mdSpinnerModel, this.blError, this.strErrorText);
}

class SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
    String txHint;
    IconData icPrefixIcon;
    List<ModelSpinner> mdSpinnerModel;
    ModelSpinner mdSpinnerModelValue;
    bool blError;
    String strErrorText;

    SpinnerState(this.txHint, this.icPrefixIcon, this.mdSpinnerModel, this.blError, this.strErrorText);

    @override
    void setState(fn) {
        super.setState(fn);
    }

    @override
    void dispose() {
        super.dispose();
    }

    void updateErrorStatus(bool blStatus) {
        setState(() {
            this.blError = blStatus;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Container(
                padding: EdgeInsets.only(left: 16, right: 15.9, top: 8),
                child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                        return InputDecorator(
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: new BorderSide(
                                                    color: Colors.blueGrey[700],
                                                    width: 4,
                                                    style: BorderStyle.solid)),
                                    hintText: txHint,
                                    labelText: txHint,
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
                                    errorText: blError ? strErrorText : null,
                                    contentPadding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 10),
                                    /*prefix: isLoading ? Container(
                                        padding: EdgeInsets.only(left: 12, right: 12),
                                        child: SizedBox(
                                                height: 5,
                                                width: 24,
                                                child: new LinearProgressIndicator(backgroundColor: Colors
                                                        .blue[100], valueColor: new AlwaysStoppedAnimation<
                                                        Color>(Constants.coloredPrimary),),)) : null,*/
                                    prefixIcon: Icon(
                                        icPrefixIcon,
                                        color: Colors.blueGrey,
                                    ),
                                    suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.blueGrey,
                                    ),
                                ),
                                isEmpty: false,
                                child: DropdownButtonHideUnderline(
                                    child: new Container(
                                        padding: new EdgeInsets.only(right: 0),
                                        child: new DropdownButton<ModelSpinner>(
                                            iconSize: 0,
                                            elevation: 2,
                                            isExpanded: false,
                                            value: mdSpinnerModelValue,
                                            isDense: true,
                                            onChanged: (ModelSpinner newValue) {
                                                setState(() {
                                                    mdSpinnerModelValue = newValue;
                                                    SpinnerData.mdSpinnerModelValue = newValue;
                                                });
                                            },
                                            hint: new Text(txHint, style: TextStyle(
                                                fontFamily: 'IBMPlexSansMedium',
                                            ),),
                                            items: mdSpinnerModel.map((ModelSpinner spinner) {
                                                return new DropdownMenuItem<ModelSpinner>(
                                                    value: spinner,
                                                    child: new Container(
                                                        child: new Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                                new Text(spinner.value, style: TextStyle(
                                                                    fontFamily: 'IBMPlexSansMedium',
                                                                ),)
                                                            ],
                                                        ),
                                                    ),
                                                );
                                            }).toList(),
                                        ),
                                    ),
                                ));
                    },
                ));
    }
}

class SpinnerData {
    static ModelSpinner mdSpinnerModelValue;
}

class SecondSpinnerData {
    static ModelSpinner mdSpinnerModelValue;
}

class SecondSpinner extends StatefulWidget {
    SecondSpinner({Key key, this.txHint, this.icPrefixIcon, this.mdSecondSpinnerModel, this.blError, this.strErrorText})
            : super(key: key);

    final String txHint;
    final IconData icPrefixIcon;
    final List<ModelSpinner> mdSecondSpinnerModel;
    final bool blError;
    final String strErrorText;

    SecondSpinnerState createState() => new SecondSpinnerState(this.txHint, this.icPrefixIcon, this.mdSecondSpinnerModel, this.blError, this.strErrorText);
}

class SecondSpinnerState extends State<SecondSpinner> {
    String txHint;
    IconData icPrefixIcon;
    List<ModelSpinner> mdSecondSpinnerModel;
    ModelSpinner mdSecondSpinnerModelValue;
    bool blError;
    String strErrorText;

    SecondSpinnerState(this.txHint, this.icPrefixIcon, this.mdSecondSpinnerModel, this.blError, this.strErrorText);

    @override
    void setState(fn) {
        super.setState(fn);
    }

    @override
    void dispose() {
        super.dispose();
    }

    void updateErrorStatus(bool blStatus) {
        setState(() {
            this.blError = blStatus;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Container(
                padding: EdgeInsets.only(left: 16, right: 15.9, top: 16, bottom: 8),
                child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                        return InputDecorator(
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: new BorderSide(
                                                    color: Colors.blueGrey[700],
                                                    width: 4,
                                                    style: BorderStyle.solid)),
                                    hintText: txHint,
                                    labelText: txHint,
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
                                    errorText: blError ? strErrorText : null,
                                    contentPadding:
                                    EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 10),
                                    /*prefix: isLoading ? Container(
                                        padding: EdgeInsets.only(left: 12, right: 12),
                                        child: SizedBox(
                                                height: 5,
                                                width: 24,
                                                child: new LinearProgressIndicator(backgroundColor: Colors
                                                        .blue[100], valueColor: new AlwaysStoppedAnimation<
                                                        Color>(Constants.coloredPrimary),),)) : null,*/
                                    prefixIcon: Icon(
                                        icPrefixIcon,
                                        color: Colors.blueGrey,
                                    ),
                                    suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.blueGrey,
                                    ),
                                ),
                                isEmpty: false,
                                child: DropdownButtonHideUnderline(
                                    child: new Container(
                                        padding: new EdgeInsets.only(right: 0),
                                        child: new DropdownButton<ModelSpinner>(
                                            iconSize: 0,
                                            elevation: 2,
                                            isExpanded: false,
                                            value: mdSecondSpinnerModelValue,
                                            isDense: true,
                                            onChanged: (ModelSpinner newValue) {
                                                setState(() {
                                                    mdSecondSpinnerModelValue = newValue;
                                                    SecondSpinnerData.mdSpinnerModelValue = newValue;
                                                });
                                            },
                                            hint: new Text(txHint, style: TextStyle(
                                                fontFamily: 'IBMPlexSansMedium',
                                            ),),
                                            items: mdSecondSpinnerModel.map((ModelSpinner secondSpinner) {
                                                return new DropdownMenuItem<ModelSpinner>(
                                                    value: secondSpinner,
                                                    child: new Container(
                                                        child: new Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                                new Text(secondSpinner.value, style: TextStyle(
                                                                    fontFamily: 'IBMPlexSansMedium',
                                                                ),)
                                                            ],
                                                        ),
                                                    ),
                                                );
                                            }).toList(),
                                        ),
                                    ),
                                ));
                    },
                ));
    }
}
