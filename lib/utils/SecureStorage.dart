import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  late FlutterSecureStorage storage;

  SecureStorage() {
    storage = new FlutterSecureStorage();
  }

  Future<String?> get(String key) async{
    String? value = await storage.read(key: key);
    return value;
  }

  set(String key,String value) async
  {
    await storage.write(key: key,value: value);
  }

  remove(String key) async
  {
    await storage.delete(key: key);
  }
}