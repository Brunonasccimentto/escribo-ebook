import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

abstract class IMainServices {

  Client clientInst() {
    return Client();
  } 

  Future<Directory> dirInst() async {
    String path = (await getApplicationDocumentsDirectory()).path; 
    return Directory(path);
  }

  HttpClient httpclientInst(){
    return HttpClient();
  }

  File fileInst () {
    return File('');
  }
}