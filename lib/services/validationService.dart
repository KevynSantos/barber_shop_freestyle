import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:intl/intl.dart';

class ValidationService
{
  static bool isDate(String input, String format) {
    try {
      final DateTime d = DateFormat(format).parseStrict(input);
      //print(d);
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  static bool dateIsValid(String inputDate)
  {
    if (isDate(inputDate, "dd/MM/yyyy")) {
      return true;
    } else {
      //print("$inputDate Date notValid");
      return false;
    }
  }

  static bool cpfIsValid(String cpf)
  {
    return CPFValidator.isValid(cpf);
  }
}