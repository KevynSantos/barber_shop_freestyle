import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/Home.dart';
import '../pages/Login.dart';
import '../utils/SecureStorage.dart';

import '../utils/HttpService.dart' as http;

import '../config.dart' as config;

import '../utils/toast.dart' as toast;

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

  static setLoginInStorage(String login, String password, String idUser) async
  {
    SecureStorage session = SecureStorage();

    await session.set('login', login);

    await session.set('password', password);

    await session.set('idUser', idUser);
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
    await session.remove('idUser');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  new Login()),
    );

  }

  static login(String login, String password) async
  {
    Map<String,String> head = new HashMap();
    Map<String,String> requestBody = new HashMap();
    requestBody.addAll({'login':login,'password':password});
    final response = await http.doPost(config.host,'/api/login/auth',head,requestBody);
    if(response.statusCode != 200)
      {
        toast.showMessageError("Ocorreu um erro inesperado");
        return false;
      }
    final responseJson = json.decode(response.body);
    var code = responseJson['code'];
    if(code != 'SUCCESS')
      {
        var messageError = responseJson['message'];
        toast.showMessageError(messageError);
        return false;
      }
    var idUser = responseJson['idUser'];
    await setLoginInStorage(login,password,idUser.toString());
    return true;
  }
}