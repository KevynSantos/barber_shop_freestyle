import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fields/Button.dart';
import '../templates/PaginationListBuilder.dart';

class SchedulingFilterCubit extends Cubit<int>
{
  SchedulingFilterCubit() : super(1);

  void next() => emit(state + 1);
  void previous() => emit(state - 1);
  
  
}

class SchedulingFilterBloc extends StatelessWidget {
  late PaginationListBuilder ancestral;
  SchedulingFilterBloc(Widget ancestral, {super.key})
  {
    this.ancestral = ancestral as PaginationListBuilder;
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
                      Navigator.pop(context),
                      ancestral.refrsh()
                    }
                  else
                    {
                      context.read<SchedulingFilterCubit>().previous()
                    }

                },Size(50, 40)).getElement(),),
              Container(
                  padding: EdgeInsets.only(right: 5.0,left: 5.0),
                  child: Button(count==2?'Salvar':'Próximo', () async => {

                    if(count == 2)
                      {
                        Navigator.pop(context),
                        ancestral.refrsh()
                      }
                    else
                      {
                        context.read<SchedulingFilterCubit>().next()
                      }

                  },Size(50, 40)).getElement())
            ]
            )]);
  }

  getStepTwo(int count, BuildContext context)
  {
    return Column(children: [
      Table(
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [getBottonsBloc(count,context)],
                ))
              ]
          )
        ],
      )
    ],);
  }

  getStepOne(int count, BuildContext context)
  {
    return Column(children: [
      Table(
        children: [
          TableRow(
              children: [
                TableCell(child: Column(
                  children: [getBottonsBloc(count,context)],
                ))
              ]
          )
        ],
      )
    ],);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (_) => SchedulingFilterCubit(),
        child: BlocBuilder<SchedulingFilterCubit, int>(
            builder: (context, count) {
              Widget bloc;

              if(count == 2)
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