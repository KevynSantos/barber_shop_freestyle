import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../blocs/SchedulingFilterBloc.dart';

class SchedulingFilter extends StatefulWidget
{

  final Widget ancestral;
  final LocalStorage storage;
  const SchedulingFilter(this.ancestral, this.storage, {Key? key}) : super(key: key);

  @override
  State<SchedulingFilter> createState() => _SchedulingFilterState(ancestral,storage);
}

class _SchedulingFilterState extends State<SchedulingFilter> {
  late Widget ancestral;
  late LocalStorage storage;
  _SchedulingFilterState(Widget ancestral,LocalStorage storage)
  {
    this.ancestral = ancestral;
    this.storage = storage;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
            color: Color(0xfff8f9e7),
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SchedulingFilterBloc(this.ancestral,this.storage)
                  ],
              ),
            )
        ),
        resizeToAvoidBottomInset: false
    );
  }
  
}