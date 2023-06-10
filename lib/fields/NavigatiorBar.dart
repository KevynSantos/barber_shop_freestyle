import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../blocs/FieldsProfile.dart';
import '../filters/SchedulingFilter.dart';
import '../pages/NewScheduling.dart';
import '../services/loginService.dart';
import '../templates/PaginationListBuilder.dart';
import '../utils/StyleText.dart';
import '../utils/DateFormatStr.dart' as date;

class NavigationBarCustom extends StatelessWidget {
  final bool isClient;
  const NavigationBarCustom(this.isClient);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyStatefulWidget(context,this.isClient);
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget(this.context, this.isClient, {super.key});
  final BuildContext context;
  final bool isClient;
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState(this.context,this.isClient);
}

Widget getSimulationInformations(int index,BuildContext context, bool isClient)
{
  if(index == 0) {
    return Column(
      children: [
        Container(
          child: Text(
            "18/02/2023 07:00 - Seu atendimento começa hoje às 10:00 hrs.",
            style: StyleText.getFontText(),),
          height: 80,
          color: Colors.amber[200],
          width: 300,
        ),
        Container(
          child: Text(
              "18/02/2023 09:00 - Já expirementou nosso Blend Capilar? Venha experimentar",
              style: StyleText.getFontText()),
          height: 80,
          color: Colors.amber[100],
          width: 300,
        )
      ],
    );
  }
  if(index == 1) {
    return Column(
      children: [
        Container(
          child: Text("Tesoura,Maquina e Barba - 18/02 às 10:00 hrs",
              style: StyleText.getFontText()),
          height: 80,
          color: Colors.amber[200],
          width: 300,
        ),
        Container(
          child: Text("Mão,Pé e Progressiva - 24/02 às 13:00 hrs",
              style: StyleText.getFontText()),
          height: 80,
          color: Colors.amber[100],
          width: 300,
        )
      ],
    );
  }
  if(index == 2 )
    {
      return Column(
        children: [
          Container(
            child: Text("Máquina - 04/02 às 17:00 hrs",style: StyleText.getFontText()),
            height: 80,
            color: Colors.amber[200],
            width: 300,
          ),
          Container(
            child: Text("Reflexo - 07/01 às 15:00 hrs",style: StyleText.getFontText()),
            height: 80,
            color: Colors.amber[100],
            width: 300,
          )
        ],
      );
    }
  if(index == 3) {

      if ((isClient == true) && index == 3) {
        return Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_test.jpg'),
              radius: 100,
            ),
            FieldsProfileBloc()

          ],
        );
      }
    if ((isClient == false) && index == 3) {
      return Column(
        children: [
          Text("Clientes")

        ],
      );
    }
  }
  if(index == 4) {
    if ((isClient == false) && index == 4) {
      return Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile_test.jpg'),
            radius: 100,
          ),
          FieldsProfileBloc()

        ],
      );
    }

  }

  return Column(
    children: [
      Text("Ocorreu algum erro ao carregar os dados")
    ],
  );

}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static Widget object = Widget as Widget;
  final BuildContext ancestral;
  final bool isClient;
  _MyStatefulWidgetState(this.ancestral, this.isClient)
  {
    object =  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
      ListView(children: [getSimulationInformations(0,this.ancestral,this.isClient)],shrinkWrap: true,padding: const EdgeInsets.all(8)),
    );
  }

  void _onItemTapped(int index) async {

    setState(() {
      object = Container();
    });

    Widget item = getSimulationInformations(index,this.ancestral,this.isClient);
    // requisição
    if(index == 1)
      {
        Map<String,String> requestBody = new HashMap();
        String? idUser = await LoginService.getIdUser();
        final LocalStorage storage = new LocalStorage('filter_scheduling');
        await storage.ready;
        var now = date.getDateFormat();
        await storage.setItem('text_data_inicial',now);
        await storage.setItem('text_data_final',now);
        requestBody.addAll({'idUser':idUser.toString(),'text_data_inicial': await storage.getItem('text_data_inicial'),'text_data_final':await storage.getItem('text_data_final')});
        object = PaginationListBuilder("/api/scheduling/list/",
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  new NewSchedulingPage()),);
              },
              backgroundColor: Colors.orange,
              child: const Icon(Icons.add),
            ),
            "agendamentos",
            requestBody,
                (index, post) {
                  var date = post['data'];
                  var hour = post['hora'];
                  var nomeFuncionario = post['nomeFuncionario'];
                  var pedidos = post['pedidos'];
                  return ListTile(
                    title: Text(date.toString()+" "+hour.toString(),maxLines: 1),
                    subtitle: Text("Funcionário: "+nomeFuncionario.toString()+"\n"+"Pedidos: "+pedidos.toString(),maxLines: 3,)
                  );
            }
        );
      }
    else if((this.isClient == false) && index == 3)
      {
        Map<String,String> requestBody = new HashMap();
        String? idUser = await LoginService.getIdUser();
        final LocalStorage storage = new LocalStorage('filter_clients');
        await storage.ready;
        await storage.setItem('text_cpf','');
        requestBody.addAll({'idUser':idUser.toString(),'text_cpf': await storage.getItem('text_cpf')});
        object = PaginationListBuilder("/api/client/list/",
            Visibility(
              visible: false, // Set it to false
              child: FloatingActionButton(onPressed: () {  },),
            ),
            "clientes",
            requestBody,
                (index, post) {
              var nome = post['nome'];
              var cpf = post['cpf'];
              var dtNascimento = post['dtNascimento'];
              var email = post['email'];
              var telefone = post['telefone'];

              return ListTile(
                  title: Text("Nome: "+nome.toString(),maxLines: 1),
                  subtitle: Text("Cpf: "+cpf.toString()+"\n"+"Dt. Nascimento: "
                      +dtNascimento.toString()+"\n"+"E-mail: "+email.toString()+"\n"+"Telefone: "+telefone.toString(),maxLines: 5,)
              );
            }
        );
      }
    else {
      object = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        ListView(children: [item],
            shrinkWrap: true,
            padding: const EdgeInsets.all(8)),
      );
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  getTitleFromTab(int index,bool isClient)
  {
    if(index == 0)
      {
        return 'Avisos';
      }
    if(index == 1)
      {
        return 'Agendamentos';
      }
    if(index == 2)
      {
        return "Histórico";
      }
    if(index == 3){
      if((isClient==true) && index==3)
      {
        return "Perfil";
      }
      if((isClient==false) && index==3)
      {
        return "Clientes";
      }
    }
    if(index == 4)
      {
        if((isClient==false) && index==4)
        {
          return "Perfil";
        }
      }
    return "Erro";
  }

  getSourceByIndex(int index, Widget object)
  {
    if(index == 1)
      {
        return <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              final LocalStorage storage = new LocalStorage('filter_scheduling');
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  new SchedulingFilter(object,storage)),);
            },
          )
        ];
      }

    return <Widget>[];
  }

  List<BottomNavigationBarItem> getBottomNavigationBar(bool isClient)
  {
    if(isClient==false)
      {
        return <BottomNavigationBarItem>[
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
              icon: Icon(Icons.person_search),
              label: 'Clientes',
              backgroundColor: Colors.black54
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
              backgroundColor: Colors.black54
          ),
        ];
      }

    return <BottomNavigationBarItem>[
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f9e7),
      appBar: AppBar(
        title: Text(getTitleFromTab(_selectedIndex,this.isClient),style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.black54,
        titleTextStyle: TextStyle(color: Colors.white),
          automaticallyImplyLeading: false,
        actions: getSourceByIndex(_selectedIndex,object)
      ),
      body: object,
      bottomNavigationBar: BottomNavigationBar(
        items: getBottomNavigationBar(this.isClient),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
        resizeToAvoidBottomInset: false
    );
  }
}
