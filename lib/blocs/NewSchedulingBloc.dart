import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fields/Button.dart';

class NewSchedulingCubit extends Cubit<int>
{
  NewSchedulingCubit(): super(1);
  
  void next() => emit(state + 1);
  void previous() => emit(state - 1);

}

class NewSchedulingBloc extends StatelessWidget {
  NewSchedulingBloc({super.key});

  getStepOne(int count, BuildContext context)
  {
    return Column(children: [
      Table(
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                    children: [Text("1"),getBottonsBloc(count,context)],
                ))
              ]
          )
        ],
      )
    ],);
  }

  getStepTwo(int count, BuildContext context)
  {
    return Column(children: [
      Table(
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [Text("2"),getBottonsBloc(count,context)],
                ))
              ]
          )
        ],
      )
    ],);
  }
  getStepThree(int count, BuildContext context)
  {
    return Column(children: [
      Table(
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [Text("3"),getBottonsBloc(count,context)],
                ))
              ]
          )
        ],
      )
    ],);
  }

  getBottonsBloc(int count, BuildContext context)
  {
      return
        Table(
            defaultColumnWidth: FixedColumnWidth(150.0),
            children:  [
        TableRow(children: [
          Container(
            padding: EdgeInsets.only(right: 5.0,left: 5.0),
            child: Button(count==1?'Cancelar':'Voltar', () async => {
              if(count == 1)
                {
                  Navigator.pop(context)
                }
              else
                {
                  context.read<NewSchedulingCubit>().previous()
                }

            },Size(50, 40)).getElement(),),
        Container(
          padding: EdgeInsets.only(right: 5.0,left: 5.0),
          child: Button(count==3?'Salvar':'Próximo', () async => {

            if(count == 3)
              {
                Navigator.pop(context)
              }
            else
              {
                context.read<NewSchedulingCubit>().next()
              }

          },Size(50, 40)).getElement())
        ]
        )]);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (_) => NewSchedulingCubit(),
        child: BlocBuilder<NewSchedulingCubit, int>(
            builder: (context, count) {
              Widget bloc;
              if(count == 3)
              {
                bloc = getStepThree(count,context);
              }
              else if(count == 2)
              {
                bloc = getStepTwo(count,context);
              }
              else
              {
                bloc = getStepOne(count,context);
              }
              return bloc;
            }
        )
    );
  }
}