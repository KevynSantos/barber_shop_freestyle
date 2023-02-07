import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fields/Button.dart';

class RegisterCubit extends Cubit<int> {
  RegisterCubit() : super(1);

  void next() => emit(state + 1);
  void previous() => emit(state - 1);
}

class RegisterBloc extends StatelessWidget {
  const RegisterBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RegisterCubit(),
        child: BlocBuilder<RegisterCubit, int>(
          builder: (context, count) { return Column(children: [
            Center(child: Text('$count')),
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
                        context.read<RegisterCubit>().previous()
                      }

                  },Size(50, 40)).getElement(),),
                  Container(
                    padding: EdgeInsets.only(right: 5.0,left: 5.0),
                    child: Button(count==4?'Concluir':'Próximo', () async => {
                      if(count==4)
                        {
                          Navigator.pop(context)
                        }
                      else
                        {
                          context.read<RegisterCubit>().next()
                        }
                    },Size(50, 40)).getElement(),
                  )
              ])
            ])
          ],);
          }
        )
      );
  }
}


