import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import '../fields/Button.dart';
import '../fields/FieldTextEdit.dart';
import '../templates/PaginationListBuilder.dart';

class ClientFilterCubit extends Cubit<int>
{
  ClientFilterCubit() : super(1);

  void update() => emit(state + 1);


}

Map<String,String> body = new HashMap();

class ClientFilterBloc extends StatelessWidget {
  late PaginationListBuilder ancestral;
  late String cpf = '';
  late LocalStorage storage;
  TextEditingController controller_cpf = TextEditingController();
  ClientFilterBloc(Widget ancestral, LocalStorage storage, {super.key})
  {
    this.ancestral = ancestral as PaginationListBuilder;
    this.storage = storage;
    controller_cpf.text = this.storage.getItem('text_cpf');
  }

  getBottonsBloc(BuildContext context)
  {
    return
      Table(
          defaultColumnWidth: FixedColumnWidth(150.0),
          children:  [
            TableRow(children: [
              Container(
                padding: EdgeInsets.only(right: 5.0,left: 5.0),
                child: Button('Cancelar', () async => {
                  Navigator.pop(context),
                  body.clear(),
                  ancestral.refrsh(body)

                },Size(50, 40)).getElement(),),
              Container(
                  padding: EdgeInsets.only(right: 5.0,left: 5.0),
                  child: Button('Filtrar', () async => {
                    await storage.setItem('text_cpf', controller_cpf.text.toString()),
                    cpf = await storage.getItem('text_cpf'),
                    body.clear(),
                    body.addAll({'text_cpf':cpf}),
                    Navigator.pop(context),
                    ancestral.refrsh(body)
                    //context.read<ClientFilterCubit>().update()
                  }

                      ,Size(50, 40)).getElement())
            ]
            )]);
  }

  getStepOne(BuildContext context, BuildContext buildContext)
  {
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 150,bottom: 20),child: Center(child: Text("Filtro",style:TextStyle(fontSize: 40)),)),
      Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [ Text("CPF: ",style: TextStyle(fontSize: 20)),
                  ],
                )),
                TableCell(child: Column(
                  children: [
                    FieldTextEdit(controller_cpf)
                  ],
                ))
              ]
          )
        ],
      ),
      Table(
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [getBottonsBloc(context)],
                ))
              ]
          )
        ],
      )
    ],);
  }

  @override
  Widget build(BuildContext buildContext) {
    // TODO: implement build
    return BlocProvider(
        create: (_) => ClientFilterCubit(),
        child: BlocBuilder<ClientFilterCubit, int>(
            builder: (context, count) {
              Widget bloc = getStepOne(context,buildContext);

              return bloc;
            }
        )
    );
  }
}