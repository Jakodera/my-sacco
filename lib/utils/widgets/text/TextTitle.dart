import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String mainText;

  const PageTitle(this.mainText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
      child: Text(
        mainText,
        style: TextStyle(
          fontFamily: 'IBMPlexSansSemiBold',
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
