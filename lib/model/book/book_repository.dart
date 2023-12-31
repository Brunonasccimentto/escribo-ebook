import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/services/api/api.dart';

class BookRepository {
  final bookApi = BookApiService();

  Future<List<BookModel>> fetchBookList() async {
    dynamic response = await bookApi.getResponse();
    final jsonData = response as List;
    List<BookModel> bookList = jsonData.map((json) => BookModel.fromJson(json)).toList();
    return bookList;
  }

  Future<String> fetchFile(String url, String filename) async {
    String response = await bookApi.getFile(url, filename);
    return response;
  }

}