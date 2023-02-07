import 'package:barber_shop_freestyle/fields/FieldText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fields/Button.dart';

class RegisterCubit extends Cubit<int> {
  RegisterCubit() : super(1);

  void next() => emit(state + 1);
  void previous() => emit(state - 1);
}

final TextEditingController _name_controller = TextEditingController();
final TextEditingController _cpf_controller = TextEditingController();
final TextEditingController _data_nascimento_controller = TextEditingController();
final TextEditingController _endereco_controller = TextEditingController();
final TextEditingController _telefone_controller = TextEditingController();
final TextEditingController _email_controller = TextEditingController();

class RegisterBloc extends StatelessWidget {
  const RegisterBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RegisterCubit(),
        child: BlocBuilder<RegisterCubit, int>(
          builder: (context, count) {
            Widget bloc;
            if(count == 1)
            {
              bloc = Column(
                children: [
                    Table(
                      children: [
                        TableRow(
                          children: [
                            TableCell(child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 278),
                                    child: Text('Nome')),
                                FieldText(null, _name_controller).getElement()
                              ],
                            )

                            ),
                          ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(right: 288),
                                      child: Text('CPF')),
                                  FieldText(null, _cpf_controller).getElement()
                                ],
                              )

                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(right: 178),
                                      child: Text('Data de Nascimento')),
                                  FieldText(null, _data_nascimento_controller).getElement()
                                ],
                              )

                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(right: 250),
                                      child: Text('Endereço')),
                                  FieldText(null, _endereco_controller).getElement()
                                ],
                              )

                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(right: 260),
                                      child: Text('Telefone')),
                                  FieldText(null, _telefone_controller).getElement()
                                ],
                              )

                              ),
                            ]
                        ),
                      ],
                    )
                ],
              );
            }

            else if(count == 2)
            {
              bloc = Column(
                  children: [
                    Table(
                      children: [
                          TableRow(
                              children: [
                                  TableCell(child: Column(
                                                      children: [
                                                              Padding(
                                                                  padding: const EdgeInsets.only(right: 278),
                                                                  child: Text('E-mail')),
                                                                          FieldText(null, _email_controller).getElement()
                                                      ],
                                                  )

                                          ),
                                        ]
                          )
                      ]
                    )
                  ]
              );

            }

            else if(count == 3)
            {
              bloc = Column(
                children: [
                  Text('Terceiro Bloco')
                ],
              );
            }

            else
            {
              bloc = Column(
                children: [
                  Text('Quarto Bloco')
                ],
              );
            }

            return Column(children: [
            Center(child: bloc,),
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


