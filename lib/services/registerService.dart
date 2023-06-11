import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../dtos/registerDto.dart';
import 'validationService.dart';
import 'dart:convert';
import '../utils/HttpService.dart' as http;
import '../config.dart' as config;
import '../utils/toast.dart' as toast;

class RegisterService
{

  static validFirstStepRegister(String cpf, String dateNasc)
  {
    bool cpfIsValid = ValidationService.cpfIsValid(cpf);


  }

  static registerUser(RegisterDto dto,BuildContext context)
  async {

    Map<String,String> head = new HashMap();
    Map<String,String> requestBody = dto.getJson();
    final response = await http.doPost(config.host,'/api/register/user',head,requestBody);

    if(response.statusCode != 200)
    {
      toast.showMessageError("Ocorreu um erro inesperado");
      return false;
    }
    final responseJson = json.decode(response.body);
    var code = responseJson['code'];
    if(code != 'SUCCESS')
    {
      var messageError = responseJson['message'];
      toast.showMessageError(getMessageErrorRegisterUser(messageError));
      return false;
    }

    toast.showMessageSuccess('Cadastro realizado com sucesso');
    return true;
  }

  static getMessageErrorRegisterUser(String message)
  {
    if(message.contains('TELEPHONE_INVALID'))
      {
        return "Telefone Inválido";
      }

    if(message.contains('CPF_INVALID'))
      {
        return "CPF Inválido";
      }
    if(message.contains('EMAIL_INVALID'))
      {
        return "E-mail inválido";
      }
    if(message.contains('LOGIN_EXIST'))
      {
        return "Login/E-mail existente no sistema";
      }

    return message;
  }


  static confirmCodeEmail(RegisterDto dto,BuildContext context)
  async {

    Map<String,String> head = new HashMap();
    Map<String,String> requestBody = dto.getJson();
    final response = await http.doPost(config.host,'/api/register/confirmCodeEmail',head,requestBody);

    if(response.statusCode != 200)
    {
      toast.showMessageError("Ocorreu um erro inesperado");
      return false;
    }
    final responseJson = json.decode(response.body);
    var code = responseJson['code'];
    if(code != 'SUCCESS')
    {
      var messageError = responseJson['message'];
      toast.showMessageError(messageError);
      return false;
    }

    toast.showMessageSuccess('Código confirmado com sucesso');
    return true;
  }

  static sendCodeVerificationEmail(RegisterDto dto,BuildContext context)
  async {

    Map<String,String> head = new HashMap();
    Map<String,String> requestBody = dto.getJson();
    final response = await http.doPost(config.host,'/api/register/sendCodeVerificationEmail',head,requestBody);

    if(response.statusCode != 200)
    {
      toast.showMessageError("Ocorreu um erro inesperado");
      return false;
    }
    final responseJson = json.decode(response.body);
    var code = responseJson['code'];
    if(code != 'SUCCESS')
    {
      var messageError = responseJson['message'];
      toast.showMessageError(messageError);
      return false;
    }

    toast.showMessageSuccess('Código enviado com sucesso');
    return true;
  }

  static tryconfirmCodeEmailAndSaveRegister(RegisterDto dto,BuildContext context)
  async {

    bool confirmCodeEmailSuccess = await confirmCodeEmail(dto,context);
    if(!confirmCodeEmailSuccess)
      {
        return false;
      }
    bool registerSucess = await registerUser(dto,context);

    return registerSucess;
  }
}