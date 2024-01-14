import 'dart:convert';
import 'dart:io';
import 'package:escribo_ebook/services/interfaces/services.dart';
import 'package:escribo_ebook/model/book/services/api/config.dart';
import 'package:escribo_ebook/model/book/services/app_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class BookApiService extends Config {
  final IServices services;

  BookApiService({required this.services});

  @override
  Future<dynamic> getResponse(String url) async {
    dynamic responseJson = [];

    try {
      final response = await services.client.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
       throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

   dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }

  Future<String> getFile(String url, String filename) async {
    String filePath = '';
    Directory directory = await services.directory;
    File file = services.file;

    try {
      final request = await services.httpClient.getUrl(Uri.parse(url));
      final response = await request.close();

      if(response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        
        filePath = '${directory.path}/$filename.epub';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      }
      else {
        filePath = 'Error code: ${response.statusCode}';
        print('falhouuuuu');
      }
    }
    catch(e){
      filePath = 'Can not fetch url: $e';
    }

    return filePath;
  }

}