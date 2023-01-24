import 'package:flutter/cupertino.dart';

import '../fields/Button.dart';
import '../fields/FieldText.dart';
import '../services/loginService.dart';

class LoginForm{
  late List<Widget> element;

  LoginForm(TextEditingController _login_controller,TextEditingController  _password_controller,BuildContext context){
    element = [Text('Login'),
      new FieldText(null,_login_controller).getElement(),
      Text('Senha'),
      new FieldText(null,_password_controller).getElement(),
      new Button('Entrar',() async => {
            await LoginService.setLoginInStorage(_login_controller.text, _password_controller.text),
            await LoginService.goHome(context)

      }).getElement()];
  }

  getElement()
  {
    return element;
  }
}