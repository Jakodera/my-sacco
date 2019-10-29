import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysacco/utils/constants/Constants.dart';

class EditText extends StatefulWidget {
    final String hintText;
    final String labelText;
    final IconData leadingIcon;
    final Color inputPrimaryColor;
    final String prefixText;
    final TextInputType keyboardType;
    final String suffixText;
    final String validatorText;
    final TextEditingController controller;
    final bool isPasswordField;
    final bool enabled;

    const EditText(this.hintText, this.labelText, this.leadingIcon,
                   {this.inputPrimaryColor,
                       this.prefixText,
                       this.keyboardType,
                       this.suffixText,
                       this.validatorText,
                       this.controller,
                       this.isPasswordField,
                       this.enabled});

    @override
    _EditTextState createState() =>
            _EditTextState(this.hintText, this.labelText, this.leadingIcon,
                    inputPrimaryColor: this.inputPrimaryColor,
                    prefixText: this.prefixText,
                    keyboardType: this.keyboardType,
                    suffixText: this.suffixText,
                    validatorText: this.validatorText,
                    controller: this.controller,
                    isPasswordField: this.isPasswordField,
                    enabled: this.enabled);
}

class _EditTextState extends State<EditText> {
    final String hintText;
    final String labelText;
    final IconData leadingIcon;
    final Color inputPrimaryColor;
    final String prefixText;
    final TextInputType keyboardType;
    final String suffixText;
    final String validatorText;
    final TextEditingController controller;
    final bool isPasswordField;
    final bool enabled;

    _EditTextState(this.hintText, this.labelText, this.leadingIcon,
                   {this.inputPrimaryColor,
                       this.prefixText,
                       this.keyboardType,
                       this.suffixText,
                       this.validatorText,
                       this.controller,
                       this.isPasswordField,
                       this.enabled});

    @override
    Widget build(BuildContext context) {
        bool blEnabled;
        if (enabled == null) {
            blEnabled = true;
        } else {
            if (enabled) {
                blEnabled = true;
            } else {
                blEnabled = false;
            }
        }

        return Container(
                child: new Theme(
                    data: new ThemeData(
                        primaryColor: Constants.coloredDarkPrimary,
                        primaryColorDark: Constants.coloredPrimary,
                    ),
                    child: new TextFormField(
                        obscureText: isPasswordField,
                        controller: controller,
                        enabled: blEnabled,
                        keyboardType: keyboardType,
                        validator: (value) {
                            if (value.isEmpty) {
                                return validatorText;
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
                            contentPadding:
                            EdgeInsets.only(left: 0, right: 10, top: 16, bottom: 14),
                            hintText: hintText,
                            labelText: labelText,
                            prefixText: prefixText,
                            suffixText: suffixText,
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
                            prefixIcon: Icon(
                                leadingIcon,
                                color: Colors.blueGrey,
                            ),
                        ),
                    ),
                ));
    }
}
