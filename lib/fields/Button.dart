import 'package:flutter/material.dart';

class Button {
  var element;
  Button(String text, Function function){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    element = ElevatedButton(
      style: style,
      onPressed: ()=> function(),
      child: Text(text),
    );
  }

  getElement()
  {
    return element;
  }
}