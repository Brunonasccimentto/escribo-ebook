import 'dart:io';

import 'package:escribo_ebook/model/book/services/database/database.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

abstract class IServices {

  final Client client = Client();
  final HttpClient httpClient = HttpClient();
  final File file = File('');
  final DatabaseService db = DatabaseService();

  Future<Directory> get directory => _dirInst();

  Future<Directory> _dirInst() async {
    String path = (await getApplicationDocumentsDirectory()).path; 
    return Directory(path);
  }
}