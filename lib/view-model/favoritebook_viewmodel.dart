import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/favorite-book/favorites_book_repository.dart';
import 'package:flutter/material.dart';

class FavoritebookViewmodel extends ChangeNotifier {
  List<BookModel> _favoriteBooks = [];

  get favoriteBooks {
    return _favoriteBooks;
  }

  Future<void> getFavoritesBookList() async {
    try {
      List<BookModel> favoriteBookList = await FavoriteBookRepository().listBooks();
      _favoriteBooks = favoriteBookList;
    } catch (e) {
      _favoriteBooks = [];
    }
    
    notifyListeners();
  }

  Future<void> saveBook(BookModel book) async {
    try {
      await FavoriteBookRepository().addBookOnFavorites(book);
      await getFavoritesBookList();
    } catch (e) {
      rethrow;
    } 
  }

  Future<void> removeBook(BookModel book) async {
    try {
      await FavoriteBookRepository().removeBookOnFavorites(book);
      await getFavoritesBookList();
    } catch (e) {
      rethrow;
    } 
  }

  checkIfBookSaved(BookModel book) async {
    return await FavoriteBookRepository().isBookSaved(book);
  }
}