import 'dart:io';
import 'package:escribo_ebook/interfaces/mainservices.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';


class MainServices implements IMainServices {

    @override
    Client clientInst() {
      return Client();
    } 

    @override
    Future<Directory> dirInst() async {
      String path = (await getApplicationDocumentsDirectory()).path; 
      return Directory(path);
    }

    @override
    HttpClient httpclientInst(){
      return HttpClient();
    }

    @override
      File fileInst () {
      return File('');
    }
}