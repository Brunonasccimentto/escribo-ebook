import 'dart:io';
import 'package:escribo_ebook/services/interfaces/services.dart';
import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/services/database/database.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

class MockServices implements IServices {

  @override
  final Client client = MockClient();
  @override
  final HttpClient httpClient = MockHttpClient();
  @override
  final File file = MockFile();
  @override
  final DatabaseService db = MockIsarDB();

  @override
  Future<Directory> get directory => _dirInst();

  Future<Directory> _dirInst() async {
    return  Directory.systemTemp;
  }

  final Isar isar = MockIsar();
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
class MockHttpResponse extends Mock implements Response {}
class MockHttpClientResponse extends Mock implements HttpClientResponse {}
class MockFile extends Mock implements File{}
class MockIsarDB extends Mock implements DatabaseService {}
class MockIsarCollection extends Mock implements IsarCollection<BookModel> {

  @override
  QueryBuilder<BookModel, BookModel, QWhere> where({bool? distinct, Sort? sort}) {
    return MockQueryBuilder();
  }
}
class MockQueryBuilder extends Mock implements QueryBuilder<BookModel, BookModel, QWhere>{
 @override
  dynamic get _query {
    // Adicione aqui qualquer lógica necessária para simular o comportamento do getter _query
    return null; // Modifique conforme necessário
  }
}
class MockIsar extends Mock implements Isar {
  final List<BookModel> mockBooks = [];
}