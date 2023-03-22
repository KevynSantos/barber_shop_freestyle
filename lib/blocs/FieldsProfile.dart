import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fields/Button.dart';
import '../fields/FieldTextEdit.dart';
import '../services/loginService.dart';
import '../utils/StyleText.dart';

class FieldsProfileCubit extends Cubit<int>
{
  FieldsProfileCubit(): super(1);

  void next() => emit(state + 1);
  void previous() => emit(state - 1);
}

class FieldsProfileBloc extends StatelessWidget
{


  getFieldsProfile(int count,BuildContext context)
  {
    if(count == 1)
      {
        TextEditingController controller_name = TextEditingController();
        TextEditingController controller_email = TextEditingController();
        TextEditingController controller_telefone = TextEditingController();
        TextEditingController controller_dtNascimento = TextEditingController();
        return Column(
          children: [
            Padding(padding: EdgeInsets.only(right: 210,bottom: 10),child: Text("Nome:",style: StyleText.getFontText(),),),
            FieldTextEdit(controller_name),
            Padding(padding: EdgeInsets.only(right: 210,top: 10,bottom: 10),child: Text("E-mail:",style: StyleText.getFontText(),),),
            FieldTextEdit(controller_email),
            Padding(padding: EdgeInsets.only(right: 190,top: 10,bottom: 10),child: Text("Telefone:",style: StyleText.getFontText(),),),
            FieldTextEdit(controller_telefone),
            Padding(padding: EdgeInsets.only(right: 120,top: 10,bottom: 20),child: Text("Dt de nascimento:",style: StyleText.getFontText(),),),
            FieldTextEdit(controller_dtNascimento),
            Table(
              defaultColumnWidth: FixedColumnWidth(100.0),
              children: [
                TableRow(
                  children: [
                    TableCell(child: IconButton(onPressed: (){
                      context.read<FieldsProfileCubit>().next();
                    }, icon: const Icon(Icons.navigate_next))),
                    TableCell(child: IconButton(onPressed: (){LoginService.logout(context);},icon: const Icon(Icons.logout))),
                  ]
                )
              ],
            )
          ],
        );
      }
    TextEditingController controller_endereco = TextEditingController();
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(right: 170,top: 50,bottom: 10),child: Text("Endereço:",style: StyleText.getFontText(),),),
        Row(
          children: [
            Container(
              width: 200,child:
            TextField(controller: controller_endereco,
            ),
            ),
            IconButton(
                icon: Icon(Icons.update),
                onPressed: () {

                })
          ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center
        ),
        Padding(padding: EdgeInsets.only(bottom: 60)),
        Button('Alterar senha',() async => {},Size(50, 50)).getElement(),
        Padding(padding: EdgeInsets.only(bottom: 60)),
        Table(
          defaultColumnWidth: FixedColumnWidth(100.0),
          children: [
            TableRow(children: [
              TableCell(child: IconButton(onPressed: (){
                context.read<FieldsProfileCubit>().previous();
              }, icon: const Icon(Icons.navigate_before)),),
              TableCell(child: IconButton(onPressed: (){LoginService.logout(context);},icon: const Icon(Icons.logout)))
            ])
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (_) => FieldsProfileCubit(),
        child: BlocBuilder<FieldsProfileCubit, int>(
          builder: (context, count) {
            return getFieldsProfile(count,context);
          }
        )
    );
  }

}