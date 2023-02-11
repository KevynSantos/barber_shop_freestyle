import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static TextStyle TextLabelStyle = TextStyle(
    color: Color(0xff293c6e),
    fontFamily: 'Roboto Condensed',
    fontSize: 17,
  );

  static InputDecoration InputFormStyle = const InputDecoration(
    enabled: true,
    contentPadding: EdgeInsets.all(10),
    constraints: BoxConstraints(maxHeight: 30),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff293c6e),
        width: 1.0,
      ),
    ),
  );

  static InputDecoration InputFormStyleLarge = const InputDecoration(
    enabled: true,
    contentPadding: EdgeInsets.all(10),
    constraints: BoxConstraints( minHeight: 50, maxHeight: 100),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff293c6e),
        width: 1.0,
      ),
    ),
  );

  static TextStyle ButtonLabelStyle = TextStyle(
      color: Color(0xff393939), fontFamily: 'Roboto Condensed', fontSize: 16);

  static ButtonStyle CommonButtonStyle = ElevatedButton.styleFrom(
      primary: const Color(0xffcbdb3a),
      minimumSize: Size(50, 15),
      padding: EdgeInsets.all(7));
}