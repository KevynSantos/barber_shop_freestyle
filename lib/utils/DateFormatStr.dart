import 'package:intl/intl.dart';

getDateFormat()
{
  final f = new DateFormat('dd/MM/yyyy');

  String date = f.format(DateTime.now());

  return  date;
}

parseDateFormat(DateTime date)
{
  final f = new DateFormat('dd/MM/yyyy');

  return f.format(date);
}