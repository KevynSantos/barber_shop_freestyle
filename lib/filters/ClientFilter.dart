import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../blocs/ClientFilterBloc.dart';

class ClientFilter extends StatefulWidget
{

  final Widget ancestral;
  final LocalStorage storage;
  const ClientFilter(this.ancestral, this.storage, {Key? key}) : super(key: key);

  @override
  State<ClientFilter> createState() => _ClientFilterState(ancestral,storage);
}

class _ClientFilterState extends State<ClientFilter> {
  late Widget ancestral;
  _ClientFilterState(Widget ancestral,LocalStorage storage)
  {
    this.ancestral = ancestral;
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
                child: ClientFilterBloc(this.ancestral)
            )
        ),
        resizeToAvoidBottomInset: false
    );
  }

}