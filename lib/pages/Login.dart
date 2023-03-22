import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../forms/LoginForm.dart';
import '../templates/BorderAndBackgroundPage.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

          return MaterialApp(
              home: const LoginPage(),
              debugShowCheckedModeBanner: false
          );

  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _login_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: BorderAndBackgroundPage.getModel(new LoginForm(_login_controller, _password_controller,context).getElement(),context),
        resizeToAvoidBottomInset: false
    );
  }
}