import 'package:barber_shop_freestyle/services/loginService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fields/Button.dart';
import '../fields/NavigatiorBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.login, {Key? key}) : super(key: key);

  final String? login;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState(login);
}

class _MyHomePageState extends State<MyHomePage> {
    var loginUsed;
  _MyHomePageState(String? login)
  {
    loginUsed = login;
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
        body: Center(
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
                        Container(child: NavigationBarCustom(),height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width),
                      ],
          ),
        )
    );
  }
}