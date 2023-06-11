import 'package:barber_shop_freestyle/fields/FieldText.dart';
import 'package:barber_shop_freestyle/services/camService.dart';
import 'package:barber_shop_freestyle/utils/cam_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../dtos/registerDto.dart';
import '../fields/Button.dart';
import '../services/registerService.dart';

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
final TextEditingController _senha_controller = TextEditingController();
final TextEditingController _confirma_senha_controller = TextEditingController();
final TextEditingController _codigo_email_controller = TextEditingController();

class RegisterBloc extends StatelessWidget {
  RegisterBloc({super.key});

  late CameraDescription firstCamera;
  late CameraDescription secondCamera;
  late CamService camService;

  static buildDto()
  {
    RegisterDto dto = new RegisterDto();
    dto.setName(_name_controller.text.toString());
    dto.setCpf(_cpf_controller.text.toString());
    dto.setAdress(_data_nascimento_controller.text.toString());
    dto.setPhone(_telefone_controller.text.toString());
    dto.setDateNasc(_data_nascimento_controller.text.toString());
    dto.setConfirmCodeEmail(_codigo_email_controller.text.toString());
    dto.setPassword(_senha_controller.text.toString());
    dto.setEmail(_email_controller.text.toString());
    dto.setConfirmCodeEmail(_codigo_email_controller.text.toString());
    return dto;
  }

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
                      defaultColumnWidth: IntrinsicColumnWidth(),
                      children: [
                        TableRow(
                          children: [
                            TableCell(child: Column(
                              children: [
                                Center(child: Padding(child: Text("Para realizar o cadastro, preencha estes campos abaixo.",style: TextStyle(fontSize: 24),),padding: EdgeInsets.only(left: 35,bottom: 20,right: 10,top:20),)),
                                Padding(
                                    padding: const EdgeInsets.only(right: 278),
                                    child: Text('Nome')),
                                FieldText(null, _name_controller,false,Null).getElement(),
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
                                  FieldText(null, _cpf_controller,false,MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')})).getElement(),
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
                                  FieldText(null, _data_nascimento_controller,false,Null).getElement(),
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
                                  FieldText(null, _endereco_controller,false,Null).getElement(),
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
                                  FieldText(null, _telefone_controller,false,Null).getElement(),
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
                                                        Center(child: Padding(child: Text("Para realizar o cadastro, preencha estes campos abaixo.",style: TextStyle(fontSize: 24),),padding: EdgeInsets.only(left: 35,bottom: 20,right: 10),)),
                                                              Padding(
                                                                  padding: const EdgeInsets.only(right: 278),
                                                                  child: Text('E-mail')),
                                                                          FieldText(null, _email_controller,false,Null).getElement(),
                                                                          Padding(padding: const EdgeInsets.only(top: 10)),
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
                                      padding: const EdgeInsets.only(right: 278),
                                      child: Text('Senha')),
                                  FieldText(null, _senha_controller,true,Null).getElement(),
                                  Padding(padding: const EdgeInsets.only(top: 10)),
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
                                      padding: const EdgeInsets.only(right: 208),
                                      child: Text('Confirmar Senha')),
                                  FieldText(null, _confirma_senha_controller,true,Null).getElement(),
                                  Padding(padding: const EdgeInsets.only(top: 10)),
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
                  Center(child: Padding(child: Text("Confirme o código que foi recebido no seu e-mail.",style: TextStyle(fontSize: 24),),padding: EdgeInsets.only(left: 35,bottom: 20,right: 10),)),
                  Center(child: Padding(child: Text("Código",style: TextStyle(fontSize: 18),),padding: EdgeInsets.only(bottom: 20),)),
                  FieldText(null, _codigo_email_controller,false,Null).getElement(),
                  Padding(padding: const EdgeInsets.only(top: 10)),
                ],
              );
            }

            else
            {
              bloc = Column(
                children: [
                  Center(child: Padding(child: Text("Deseja adicionar uma foto de perfil no seu cadastro?",style: TextStyle(fontSize: 24),),padding: EdgeInsets.only(left: 35,bottom: 20,right: 10),)),
                  Center(child: Padding(child: Text("Caso não queira, selecione em concluir",style: TextStyle(fontSize: 18),),padding: EdgeInsets.only(bottom: 20),)),
                  Button('Tirar Foto', () async => {
                    camService = CamService(),
                    await camService.init(),
                    firstCamera = camService.getFirstCamera(),
                    secondCamera = camService.getSecondCamera(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  CamView(
                          firstCamera,
                          secondCamera,
                              (image, context) async {
                            print(image);
                            return true;
                          })),
                    )

                  }, Size(50, 40)).getElement()
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
                      if(count==2)
                        {
                          if(await RegisterService.sendCodeVerificationEmail(await buildDto(), context))
                            {
                              context.read<RegisterCubit>().next()
                            }
                        }
                      else if(count==3)
                        {
                          if(await RegisterService.tryconfirmCodeEmailAndSaveRegister(await buildDto(), context))
                            {
                              context.read<RegisterCubit>().next()
                            }

                        }
                      else if(count==4)
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


