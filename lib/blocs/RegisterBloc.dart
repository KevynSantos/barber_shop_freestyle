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
            Button(count==1?'Cancelar':'Voltar', () async => {
              if(count == 1)
                {
                  Navigator.pop(context)
                }
              else
                {
                  context.read<RegisterCubit>().previous()
                }

            }).getElement(),
            Button(count==3?'Concluir':'Próximo', () async => {
              if(count==3)
                {
                  Navigator.pop(context)
                }
              else
                {
                  context.read<RegisterCubit>().next()
                }
            }).getElement()
          ],);
          }
        )
      );
  }
}


