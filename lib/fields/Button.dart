import 'package:flutter/material.dart';

class Button {
  var element;
  Button(String text, Function function){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),primary: Color(0xffc7baa7),minimumSize: Size(280, 50));
    element = ElevatedButton(
      style: style,
      onPressed: ()=> function(),
      child: Text(text,style: TextStyle(color: Colors.black)),
    );
  }

  getElement()
  {
    return element;
  }
}