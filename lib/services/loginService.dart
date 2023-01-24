import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/Home.dart';
import '../pages/Login.dart';
import '../utils/SecureStorage.dart';

class LoginService{
  static Future<Map<String, String>?> checkLogin() async
  {
    var result = await hasLoginInStorage();

    return result;
  }

  static Future<Map<String, String>?> hasLoginInStorage() async
  {
    final Map<String, String> loginUser = HashMap();

    SecureStorage session = SecureStorage();

    var login = await session.get("login");

    if(login != null)
    {
      var senha = await session.get("password");

      loginUser.addAll({'login':login,'password':senha.toString()});

      return loginUser;
    }

    return null;
  }

  static setLoginInStorage(String login, String password) async
  {
    SecureStorage session = SecureStorage();

    await session.set('login', login);

    await session.set('password', password);
  }

  static goHome(BuildContext context) async
  {
    var loginData = await hasLoginInStorage();

    String? login = loginData?.remove("login");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  new MyHomePage(login)),
    );
  }

  static logout(BuildContext context) async
  {
    SecureStorage session = SecureStorage();
    await session.remove('login');
    await session.remove('password');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  new Login()),
    );

  }
}