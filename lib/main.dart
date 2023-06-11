import 'package:barber_shop_freestyle/pages/Home.dart';
import 'package:barber_shop_freestyle/pages/Login.dart';
import 'package:barber_shop_freestyle/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

var existsLogin = false;
var loginInStorage;
var login = null;
var isClient = null;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<String> checkLogin()
  async {
    loginInStorage = await LoginService.checkLogin();
    login = loginInStorage!=null?loginInStorage.remove('login'):null;
    loginInStorage!=null?existsLogin = true:existsLogin = false;
    if(existsLogin)
      {
        isClient = await LoginService.isClient();
      }
    return [''].join('');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: checkLogin(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return MaterialApp(
              home: existsLogin?MyHomePage(login,isClient):Login(),
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
          );
        }

    );
  }
}


