import 'package:escribo_ebook/interfaces/mainservices.dart';
import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/favorite-book/favorites_book_repository.dart';
import 'package:flutter/material.dart';

class FavoritebookViewmodel extends ChangeNotifier {
  final IMainServices mainServices;

  FavoritebookViewmodel({required this.mainServices});

  List<BookModel> _favoriteBooks = [];

  get favoriteBooks {
    return _favoriteBooks;
  }

  Future<void> getFavoritesBookList() async {
    try {
      List<BookModel> favoriteBookList = await FavoriteBookRepository(mainServices: mainServices).listBooks();
      _favoriteBooks = favoriteBookList;
    } catch (e) {
      _favoriteBooks = [];
    }
    
    notifyListeners();
  }

  Future<void> saveBook(BookModel book) async {
    try {
      await FavoriteBookRepository(mainServices: mainServices).addBookOnFavorites(book);
      await getFavoritesBookList();
    } catch (e) {
      rethrow;
    } 
  }

  Future<void> removeBook(BookModel book) async {
    try {
      await FavoriteBookRepository(mainServices: mainServices).removeBookOnFavorites(book);
      await getFavoritesBookList();
    } catch (e) {
      rethrow;
    } 
  }

  Future<bool> checkIfBookSaved(BookModel book) async {
    return await FavoriteBookRepository(mainServices: mainServices).isBookSaved(book);
  }
}