import 'package:flutter/material.dart';

import '../services/loginService.dart';
import 'Button.dart';

class NavigationBarCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyStatefulWidget(context);
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget(this.context, {super.key});
  final BuildContext context;
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState(this.context);
}

Widget getSimulationInformations(int index,BuildContext context)
{
  switch(index){
    case 0:
      return Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 30),
          child: Center(
            child: Text("Avisos",style: TextStyle(fontSize: 20)),
          ),),
          Container(
            child: Text("18/02/2023 07:00 - Seu atendimento começa hoje às 10:00 hrs."),
            height: 50,
            color: Colors.amber[200],
            width: 300,
          ),
          Container(
            child: Text("18/02/2023 09:00 - Já expirementou nosso Blend Capilar? Há disponível para compra."),
            height: 50,
            color: Colors.amber[100],
            width: 300,
          )
        ],
      );
    case 1:
      return Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 30),
            child: Center(
              child: Text("Agendamentos",style: TextStyle(fontSize: 20)),
            ),),
          Container(
            child: Text("Tesoura,Maquina e Barba - 18/02 às 10:00 hrs"),
            height: 50,
            color: Colors.amber[200],
            width: 300,
          ),
          Container(
            child: Text("Mão,Pé e Progressiva - 24/02 às 13:00 hrs"),
            height: 50,
            color: Colors.amber[100],
            width: 300,
          )
        ],
      );
    case 2:
      return Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 30),
            child: Center(
              child: Text("Histórico",style: TextStyle(fontSize: 20)),
            ),),
          Container(
            child: Text("Máquina - 04/02 às 17:00 hrs"),
            height: 50,
            color: Colors.amber[200],
            width: 300,
          ),
          Container(
            child: Text("Reflexo - 07/01 às 15:00 hrs"),
            height: 50,
            color: Colors.amber[100],
            width: 300,
          )
        ],
      );
    case 3:
      return Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 30),
            child: Center(
              child: Text("Perfil",style: TextStyle(fontSize: 20)),
            ),),
          context != null?Button('Sair',() async => {LoginService.logout(context)},Size(50, 50)).getElement():
          Button('Sair',() async => {},Size(50, 50)).getElement()
        ],
      );
    default:
      return Column(
        children: [
          Text("Ocorreu algum erro ao carregar os dados")
        ],
      );
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static Widget object = Widget as Widget;
  final BuildContext ancestral;
  _MyStatefulWidgetState(this.ancestral)
  {
    object =  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
      ListView(children: [getSimulationInformations(0,this.ancestral)],shrinkWrap: true),
    );
  }

  void _onItemTapped(int index) async {

    Widget item = getSimulationInformations(index,this.ancestral);
    // requisição
    object = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
      ListView(children: [item],shrinkWrap: true, padding: const EdgeInsets.all(8)),
    );

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: object,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Avisos',
              backgroundColor: Colors.black54
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Agendamentos',
              backgroundColor: Colors.black54
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Histórico',
              backgroundColor: Colors.black54
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: Colors.black54
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
