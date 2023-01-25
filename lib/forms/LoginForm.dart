import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fields/Button.dart';
import '../fields/FieldText.dart';
import '../services/loginService.dart';

class LoginForm{
  late List<Widget> element;

  LoginForm(TextEditingController _login_controller,TextEditingController  _password_controller,BuildContext context){
    element = [
      Align(child: Column(children: [Text('Barber Shop FreeStyle',style: TextStyle(color: Colors.white,fontSize: 30)),Image.asset('assets/images/BarberShopFreeStyle-logo-semFundo.png',width: 80,height: 80,)],),alignment: Alignment.topCenter,),
      Padding( padding: EdgeInsets.only(left: 17.0,top: 30),
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

      }).getElement()];
  }

  getElement()
  {
    return element;
  }
}