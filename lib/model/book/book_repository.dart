
import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/interface/ibook.dart';
import 'package:escribo_ebook/model/book/services/api/api.dart';
import 'package:escribo_ebook/model/book/services/api/api_endpoints.dart';


class BookRepository extends IbookRepository {
  final BookApiService bookApi;

  BookRepository({required this.bookApi});

  @override
  Future<List<BookModel>> listBooks() async {
    dynamic response = await bookApi.getResponse(ApiEndPoints().getBooks);
    final jsonData = response as List;
    List<BookModel> bookList = jsonData.map((json) => BookModel.fromJson(json)).toList();
    return bookList;
  }

  @override
  Future<String> fetchFile(String url, String filename) async {
    String response = await bookApi.getFile(url, filename);
    return response;
  }

}