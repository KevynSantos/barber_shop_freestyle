import 'package:http/http.dart' as http;

doPost(String url, String path , Map<String, String> header, Map<String,String> requestBody)
{
  final response =  http.post(
    Uri.parse(url+path),
    headers: header,
    body: requestBody,
  );

  return response;
}

doGet(String url, String path , Map<String, String> header, Map<String,String> parameters)
{
  var parametersStr = new StringBuffer();
  int size = parameters.length;
  int count = 0;
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

  final response =  http.get(
    Uri.http(url,path+parametersStr.toString()),
    headers: header,
  );

  return response;
}