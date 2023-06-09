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
              child: SchedulingFilterBloc(this.ancestral,this.storage)
            )
        ),
        resizeToAvoidBottomInset: false
    );
  }
  
}