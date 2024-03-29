import 'package:barber_shop_freestyle/services/loginService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fields/Button.dart';
import '../fields/NavigatiorBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.login, this.isClient, {Key? key}) : super(key: key);

  final String? login;
  final bool isClient;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState(login,isClient);
}

class _MyHomePageState extends State<MyHomePage> {
    var loginUsed;
    late bool isClient;
  _MyHomePageState(String? login, bool isClient)
  {
    loginUsed = login;
    this.isClient = isClient;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Container(child: NavigationBarCustom(this.isClient),height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width)
    );
  }
}