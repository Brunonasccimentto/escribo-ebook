import 'dart:io';
import 'package:escribo_ebook/services/interfaces/services.dart';
import 'package:escribo_ebook/model/book/services/database/database.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';


class MainServices implements IServices {

  @override
  final Client client = Client();
  @override
  final HttpClient httpClient = HttpClient();
  @override
  final File file = File('');
  @override
  final DatabaseService db = DatabaseService();

  @override
  Future<Directory> get directory => _dirInst();  

  Future<Directory> _dirInst() async {
    String path = (await getApplicationDocumentsDirectory()).path; 
    return Directory(path);
  }
}