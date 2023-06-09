import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calendar
{
  void showDate(BuildContext context,Function functionNewValue)
  {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030)
    ).then(functionNewValue());
  }
}