import 'package:flutter/material.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/utils/constants/Constants.dart';
import 'package:mysacco/utils/storage/Storage.dart';

class Confirmation {
    String strTitle;
    String strDescription;
    String strXML;
    Column tbDescription;
    Storage storage;
    PageMetaData metadata;

    Confirmation(this.strTitle, this.strXML, this.tbDescription, this.storage, this.metadata);
}

class ConfirmationTable {
    static TableRow trBuildTableRow(String key, String value) {
        return TableRow(
            children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                            key,
                            style: TextStyle(
                                    fontFamily: 'IBMPlexSansSemiBold',
                                    fontSize: 17.6,
                                    color: Constants.keypadColor,
                                    fontWeight: FontWeight.w500
                            )
                    ),
                    padding: EdgeInsets.only(left: 6, right: 4, top: 4, bottom: 4),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                            value,
                            style: TextStyle(
                                    fontFamily: 'IBMPlexSansSemiBold',
                                    fontSize: 17.6,
                                    color: Constants.coloredPrimary,
                                    fontWeight: FontWeight.w500
                            )
                    ),
                    padding: EdgeInsets.only(left: 6, right: 4, top: 4, bottom: 4),
                ),
            ],
        );
    }
}