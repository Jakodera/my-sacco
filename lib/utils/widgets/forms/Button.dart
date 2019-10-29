import 'package:flutter/material.dart';

class IconedButton extends StatefulWidget {
    final Function nextAction;
    final IconData buttonIcon;
    final String buttonLabel;
    final Color buttonColor;

    const IconedButton(this.buttonLabel,
                       this.nextAction, {
                           this.buttonColor,
                           this.buttonIcon,
                       });

    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return _IconedButtonState(this.nextAction, this.buttonLabel,
                buttonIcon: this.buttonIcon, buttonColor: buttonColor);
    }
}

class _IconedButtonState extends State<IconedButton> {
    final Function nextAction;
    final IconData buttonIcon;
    final String buttonLabel;
    final Color buttonColor;

    _IconedButtonState(this.nextAction, this.buttonLabel,
                       {this.buttonIcon, this.buttonColor});

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    FloatingActionButton.extended(
                        backgroundColor: buttonColor,
                        elevation: 1.2,
                        shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                        icon: Icon(buttonIcon),
                        label: Text(
                            buttonLabel,
                            style: TextStyle(
                                fontSize: 14.5,
                                fontFamily: 'IBMPlexSansSemiBold',
                            ),
                        ),
                        onPressed: nextAction,
                    ),
                ],
            ),
            constraints: BoxConstraints.tightForFinite(),
        );
    }
}


class PlainButton extends StatefulWidget {
    final Function nextAction;
    final String buttonLabel;
    final Color buttonColor;

    const PlainButton(this.buttonLabel,
                       this.nextAction, {
                           this.buttonColor,
                       });

    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return _PlainButtonState(this.nextAction, this.buttonLabel, buttonColor: buttonColor);
    }
}

class _PlainButtonState extends State<PlainButton> {
    final Function nextAction;
    final String buttonLabel;
    final Color buttonColor;

    _PlainButtonState(this.nextAction, this.buttonLabel,
                       {this.buttonColor});

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    new RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        textColor: Colors.white,
                        color: buttonColor,
                        onPressed: nextAction,

                        child: new Text(buttonLabel, style: new TextStyle(
                            fontFamily: 'IBMPlexSansSemiBold',
                        ),),
                    ),
                ],
            ),
            constraints: BoxConstraints.tightForFinite(),
        );
    }
}
