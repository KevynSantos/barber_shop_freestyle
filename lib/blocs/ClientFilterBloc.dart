import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../fields/Button.dart';
import '../templates/PaginationListBuilder.dart';

class ClientFilterCubit extends Cubit<int>
{
  ClientFilterCubit() : super(1);

  void update() => emit(state + 1);


}

Map<String,String> body = new HashMap();

class ClientFilterBloc extends StatelessWidget {
  late PaginationListBuilder ancestral;
  final maskCpf = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  late LocalStorage storage;

  ClientFilterBloc(Widget ancestral, {super.key})
  {
    this.ancestral = ancestral as PaginationListBuilder;
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
                    storage = new LocalStorage("filter_client"),
                    await storage.ready,
                    body.clear(),
                    body.addAll({'text_cpf':await storage.getItem('text_cpf')}),
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
                    TextField(inputFormatters: [maskCpf],onChanged: (String value) async =>{

                      this.storage = new LocalStorage("filter_client"),
                      await this.storage.ready,
                      await this.storage.setItem('text_cpf', value)

                    },)
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