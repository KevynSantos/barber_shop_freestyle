import 'package:flutter/material.dart';

class Button {
  var element;
  Button(String text, Function function, Size size){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),primary: Color(0xffedcc90),minimumSize: size);
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