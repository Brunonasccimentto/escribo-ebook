
import 'package:escribo_ebook/model/book/book.dart';

abstract class IbookRepository {
  Future<String> fetchFile(String url, String filename);
  Future<List<BookModel>> listBooks();

}