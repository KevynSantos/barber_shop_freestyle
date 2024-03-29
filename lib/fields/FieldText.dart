import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FieldText
{
  var element;

  FieldText(String? text, TextEditingController controller, bool obscureText, Object mask){
    element = SizedBox(
        width: 320.0,
        child: TextField(
          inputFormatters: mask != Null?[mask as MaskTextInputFormatter]:[],
          style: TextStyle(color: Colors.black),
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // change color you want...
          ),
          labelText: text,
            labelStyle: TextStyle(fontSize: 13, backgroundColor: Colors.black,color: Colors.black),
            hintStyle: TextStyle(backgroundColor: Colors.black,color: Colors.black),
            focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
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