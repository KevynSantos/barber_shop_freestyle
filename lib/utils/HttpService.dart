import 'package:barber_shop_freestyle/utils/toast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

doPost(String url, String path , Map<String, String> header, Map<String,String> requestBody)
async {
  await EasyLoading.show(status: 'carregando...');
  var response = null;
  try
  {
    response =  await http.post(
      Uri.parse(url+path),
      headers: header,
      body: requestBody,
    );
  }
  on Exception catch (exception) {
    showMessageError(exception.toString());
  }
  finally {
    await EasyLoading.dismiss();
  }

  return response;
}

doGet(String url, String path , Map<String, String> header, Map<String,String> parameters)
async {
  var parametersStr = new StringBuffer();
  int size = parameters.length;
  int count = 0;
  if(size > 0)
    {
      parametersStr.write("?");
    }
  parameters.forEach((key, value) {
    if(count == size)
    {
      parametersStr.write(key+"="+value);
    }
    else
    {
      parametersStr.write(key+"="+value+"&");
    }
    count++;
  });
  await EasyLoading.show(status: 'carregando...');
  var response = null;
  try
  {
    response =  await http.get(
      Uri.parse(url+path+parametersStr.toString()),
      headers: header,
    );
  }
  on Exception catch (exception) {
    showMessageError(exception.toString());
  }
  finally
  {
    await EasyLoading.dismiss();
  }

  return response;
}