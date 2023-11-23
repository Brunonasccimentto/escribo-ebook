
import 'dart:convert';
import 'dart:io';
import 'package:escribo_ebook/models/book/services/config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class BookApiService extends Config {

  Future getResponse() async {
    dynamic responseJson = [];
    
    try {
      final response = await http.get(Uri.parse(baseUrl));
      responseJson = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }

    return responseJson;
  }

  Future<String> getFile(String url, String filename) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String dir = (await getApplicationDocumentsDirectory()).path;

    try {
      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();

      if(response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        
        filePath = '$dir/$filename.epub';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      }
      else {
        filePath = 'Error code: ${response.statusCode}';
      }
    }
    catch(e){
      filePath = 'Can not fetch url: $e';
    }

    return filePath;
  }

}