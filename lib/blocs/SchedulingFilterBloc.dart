import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fields/Button.dart';
import '../templates/PaginationListBuilder.dart';
import '../utils/DateFormatStr.dart';
import '../templates/Calendar.dart' as c;

class SchedulingFilterCubit extends Cubit<int>
{
  SchedulingFilterCubit() : super(1);

  void update() => emit(state + 1);
  
  
}

String dateInit = getDateFormat();
String dateEnd = getDateFormat();

Map<String,String> body = new HashMap();

class SchedulingFilterBloc extends StatelessWidget {
  late PaginationListBuilder ancestral;
  SchedulingFilterBloc(Widget ancestral, {super.key})
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
                  ancestral.refrsh(body)

                },Size(50, 40)).getElement(),),
              Container(
                  padding: EdgeInsets.only(right: 5.0,left: 5.0),
                  child: Button('Filtrar', () async => {
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
      Table(
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [ Text("Data Inicial: "+dateInit),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDatePicker(
                            context: buildContext,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030)
                        ).then((value) =>{
                          dateInit = parseDateFormat(value as DateTime),
                          context.read<SchedulingFilterCubit>().update()
                        });
                      },
                    ),],
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
                  children: [ Text("Data Final: "+dateEnd),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDatePicker(
                            context: buildContext,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030)
                        ).then((value) =>{
                          dateEnd = parseDateFormat(value as DateTime),
                          context.read<SchedulingFilterCubit>().update()
                        });
                      },
                    ),],
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