import 'package:flutter/material.dart';

class FieldText
{
  var element;

  FieldText(String? text, TextEditingController controller){
    element = TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
      ),
      controller: controller,
    );
  }

  getElement()
  {
    return element;
  }
}