import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fields/Button.dart';
import '../fields/FieldText.dart';
import '../services/loginService.dart';

class LoginForm{
  late List<Widget> element;

  LoginForm(TextEditingController _login_controller,TextEditingController  _password_controller,BuildContext context){
    element = [
      Align(child: Column(children: [Text('Barber Shop FreeStyle',style: TextStyle(color: Colors.white,fontSize: 31,fontWeight: FontWeight.bold,fontFamily: 'Fantasy')),Container(child: Image.asset('assets/images/BarberShopFreeStyle-logo-semFundo.png',width: 80,height: 80,),margin:  const EdgeInsets.only(left: 10.0, right: 0.0),)],),alignment: Alignment.center,),
      Padding( padding: EdgeInsets.only(left: 17.0,top: 20),
        child: Align(child: Text('Login',style: TextStyle(color: Colors.white)),alignment: Alignment.centerLeft,)),
      new FieldText(null,_login_controller).getElement(),
      Padding(padding: EdgeInsets.all(10)),
      Padding( padding: EdgeInsets.only(left: 17.0),
      child: Align(child: Text('Senha',style: TextStyle(color: Colors.white)),alignment: Alignment.centerLeft,)),
      new FieldText(null,_password_controller).getElement(),
      Padding(padding: EdgeInsets.all(10)),
      new Button('Fazer Login',() async => {
            await LoginService.setLoginInStorage(_login_controller.text, _password_controller.text),
            await LoginService.goHome(context)

      }).getElement(),
    Container(
      padding: EdgeInsets.only(left: 100,right: 80,top: 20,bottom: 20),
      child: Table(children: [TableRow(children: [
        new InkWell(
            child: new Text('Cadastre-se',style: TextStyle(decoration: TextDecoration.underline, color: Colors.white,fontSize: 16)),
            onTap: () => print('teste')),
        new InkWell(
            child: new Text('Esqueceu sua senha',style: TextStyle(decoration: TextDecoration.underline, color: Colors.white,fontSize: 16)),
            onTap: () => print('teste'))
      ])],),
    )
    ];
  }

  getElement()
  {
    return element;
  }
}