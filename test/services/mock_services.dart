import 'dart:convert';
import 'dart:io';
import 'package:escribo_ebook/interfaces/mainservices.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

class MockServices implements IMainServices {
  @override
  Client clientInst() {
    return MockClient();
  }

  @override
  Future<Directory> dirInst() async {
    return MockDiretory();
  }

  @override
  HttpClient httpclientInst() {
    return MockHttpClient();
  }
  
  @override
  File fileInst() {
    return MockFile();
  }
 
}

class MockClient extends Mock implements Client{}
class MockDiretory extends Mock implements Directory{}
class MockHttpClient extends Mock implements HttpClient{}
class MockHttpClientRequest extends Mock implements HttpClientRequest {
  @override
  Future<HttpClientResponse> get done => throw 'https://www.gutenberg.org/ebooks/72127.epub.images';
  @override
   get uri => throw Uri(
    scheme: 'https',
    host: 'dart.dev',
    path: '/guides/libraries/library-tour',
    fragment: 'numbers');
}
class MockHttpClientResponse extends Mock implements HttpClientResponse {}
class MockFile extends Mock implements File{}
class MockIsarDB extends Mock implements Isar {}