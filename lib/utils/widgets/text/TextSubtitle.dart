import 'package:flutter/material.dart';

class PageSubtitle extends StatelessWidget {
    final String mainText;

    const PageSubtitle(this.mainText);

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Text(
                mainText,
                style: new TextStyle(
                        fontFamily: 'IBMPlexSansSemiBold',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500]),
            ),
        );
    }
}
