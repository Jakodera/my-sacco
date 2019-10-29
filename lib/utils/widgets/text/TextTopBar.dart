import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
    final String topBarText;
    final String hintInfo;
    final String moreDetailsText;

    TopBar(this.topBarText,
           {this.moreDetailsText = "Or choose from below",
               this.hintInfo = "What would you want to do?"});

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    child: Text(
                        topBarText,
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'IBMPlexSansSemiBold',
                            //color: Colors.grey[900],
                            fontWeight: FontWeight.w600,
                        ),
                    ),
                ),
                /*Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.blueGrey[300],
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: hintInfo,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blueGrey[300],
                ),
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[300],
                ),
              ),
              maxLines: 1,
              controller: _searchControl,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0),
          alignment: Alignment.centerLeft,
          child: Text(
            moreDetailsText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
        ),*/
            ],
        );
    }
}
