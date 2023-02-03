import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderAndBackgroundPage
{
  static getIconBorder()
  {
    return BoxDecoration(
        image: new DecorationImage(image: new AssetImage('assets/images/icon-border-app.png'), fit: BoxFit.cover,),
    );
  }

  static getModel(Widget content,BuildContext context)
  {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      height:  MediaQuery.of(context).size.height,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 30.0,
            decoration: getIconBorder(),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 60.0,
            color: Color(0xfff8f9e7),
            child: content,
          ),
          Container(
            width: 30.0,
            decoration: getIconBorder(),
          ),
        ],
      ),
    );
  }
}

