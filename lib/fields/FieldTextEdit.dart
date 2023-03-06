import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldTextEdit extends StatelessWidget{
  late TextEditingController controller;
  FieldTextEdit(this.controller,{super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FieldTextEditStatefulWidget(this.controller);
  }
}

class FieldTextEditStatefulWidget extends StatefulWidget {
  late TextEditingController controller;
  FieldTextEditStatefulWidget(this.controller, {super.key});
  @override
  State<FieldTextEditStatefulWidget> createState() => _FieldTextEditMyStatefulWidgetState(this.controller);
}

class _FieldTextEditMyStatefulWidgetState extends State<FieldTextEditStatefulWidget> {
  bool _isEnable = false;
  late TextEditingController controller;

  _FieldTextEditMyStatefulWidgetState(this.controller);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          child: TextField(
            controller: this.controller,
            enabled: _isEnable,
            onSubmitted: (String value){
                setState(() {
                  if(_isEnable)
                  {
                    _isEnable = false;
                  }
                  else
                  {
                    _isEnable = true;
                  }
                });
            },
          ),
        ),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                if(_isEnable)
                  {
                    _isEnable = false;
                  }
                else
                  {
                    _isEnable = true;
                  }
              });
            })
      ],
    );
  }

}