import 'package:barber_shop_freestyle/pages/Home.dart';
import 'package:barber_shop_freestyle/pages/Login.dart';
import 'package:barber_shop_freestyle/services/loginService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

bool existsLogin = false;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<String> checkLogin()
  async {
    existsLogin = await LoginService.checkLogin();
    return [''].join('');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: checkLogin(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return MaterialApp(
              home: existsLogin?MyHomePage():Login()
          );
        }

    );
  }
}


