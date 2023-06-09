import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

import '../fields/Button.dart';
import '../templates/PaginationListBuilder.dart';
import '../utils/DateFormatStr.dart';
import '../templates/Calendar.dart' as c;

class SchedulingFilterCubit extends Cubit<int>
{
  SchedulingFilterCubit() : super(1);

  void update() => emit(state + 1);
  
  
}

Map<String,String> body = new HashMap();

class SchedulingFilterBloc extends StatelessWidget {
  late PaginationListBuilder ancestral;
  late String dateInit = getDateFormat();
  late String dateEnd = getDateFormat();
  late LocalStorage storage;
  SchedulingFilterBloc(Widget ancestral, LocalStorage storage, {super.key})
  {
    this.ancestral = ancestral as PaginationListBuilder;
    this.storage = storage;
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
                  ancestral.refrsh(body)

                },Size(50, 40)).getElement(),),
              Container(
                  padding: EdgeInsets.only(right: 5.0,left: 5.0),
                  child: Button('Filtrar', () async => {
                            dateInit = await storage.getItem('text_data_inicial'),
                            dateEnd = await storage.getItem('text_data_final'),
                            body.clear(),
                            body.addAll({'text_data_inicial':dateInit,'text_data_final':dateEnd,
                            'text_hora_inicial':'00:00','text_hora_final':'23:59'}),
                            Navigator.pop(context),
                            ancestral.refrsh(body)
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
                  children: [ Text("Data Inicial: "+storage.getItem('text_data_inicial'),style: TextStyle(fontSize: 20)),
                    ],
                )),
                TableCell(child: Column(
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(bottom: 30),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showDatePicker(
                            context: buildContext,
                            initialDate: storage.getItem('text_data_inicial') == Null?DateTime.now():DateFormat('dd/MM/yyyy').parse(storage.getItem('text_data_inicial')),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030)
                        ).then((value) async =>{
                          dateInit = parseDateFormat(value as DateTime),
                          await storage.ready,
                          await storage.setItem('text_data_inicial', dateInit),
                          context.read<SchedulingFilterCubit>().update()
                        });
                      },
                    )
                  ],
                ))
              ]
          )
        ],
      ),
      Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [ Text("Data Final: "+storage.getItem('text_data_final'),style: TextStyle(fontSize: 20)),
                    ],
                )),
                TableCell(child: Column(
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(bottom: 30),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showDatePicker(
                            context: buildContext,
                            initialDate: storage.getItem('text_data_final') == Null?DateTime.now():DateFormat('dd/MM/yyyy').parse(storage.getItem('text_data_final')) ,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030)
                        ).then((value) async =>{
                          dateEnd = parseDateFormat(value as DateTime),
                          await storage.ready,
                          await storage.setItem('text_data_final', dateEnd),
                          context.read<SchedulingFilterCubit>().update()
                        });
                      },
                    )
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
        create: (_) => SchedulingFilterCubit(),
        child: BlocBuilder<SchedulingFilterCubit, int>(
            builder: (context, count) {
              Widget bloc = getStepOne(context,buildContext);

              return bloc;
            }
        )
    );
  }
}