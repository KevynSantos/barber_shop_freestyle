import 'package:flutter/material.dart';

class FieldText
{
  var element;

  FieldText(String? text, TextEditingController controller){
    element = SizedBox(
        width: 380.0,
        child: TextField(
          style: TextStyle(color: Colors.white),
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // change color you want...
          ),
          labelText: text,
            labelStyle: TextStyle(fontSize: 13, backgroundColor: Colors.white,color: Colors.white),
            hintStyle: TextStyle(backgroundColor: Colors.white,color: Colors.white),
            focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
        )
        ),
        controller: controller,
       )
    );
  }

  getElement()
  {
    return element;
  }
}