

import 'package:escribo_ebook/model/book/book.dart';

abstract class IfavoriteBooks {
  Future<void> addBookOnFavorites(BookModel book);
  Future<void> removeBookOnFavorites(BookModel book);
  Future<bool> isBookSaved(BookModel book);
}