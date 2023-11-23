import 'dart:io';
import 'package:escribo_ebook/models/book/book.dart';
import 'package:escribo_ebook/models/book/book_repository.dart';
import 'package:escribo_ebook/models/book/services/database/favorites_book_repository.dart';
import 'package:escribo_ebook/shared/enums/loading.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookViewModel extends ChangeNotifier {
  List<BookModel> _bookApiResponse = [];

  get bookApiResponse {
    return _bookApiResponse;
  }

  Future<void> fetchBookData() async {
    try {
      List<BookModel> bookList = await BookRepository().fetchBookList();
      _bookApiResponse = bookList;
    } catch (e) {
      _bookApiResponse = [];
    }
    
    notifyListeners();
  }

  String _bookApiFilePathResponse = '';
  LoadingStatus loading = LoadingStatus.completed;

  get bookApiFilePathResponse {
    return _bookApiFilePathResponse;
  }

  Future<void> downloadBook(String url, String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String filePath = '$dir/$filename.epub';
    bool thisBookIsDownloaded = await checkIfBookDownloaded(filePath);

    if(thisBookIsDownloaded) {
      loading = LoadingStatus.alreadyDownloaded;
      notifyListeners();

      _bookApiFilePathResponse = filePath;
      
    } else {
      loading = LoadingStatus.loading;
      notifyListeners();

      String newfilePath = await BookRepository().fetchFile(url, filename);
      _bookApiFilePathResponse = newfilePath;
    }

    loading = LoadingStatus.completed;
    notifyListeners();
  }

  List<BookModel> _favoriteBooks = [];

  get favoriteBooks {
    return _favoriteBooks;
  }

  Future<void> getFavoritesBookList() async {
    try {
      List<BookModel> favoriteBookList = await FavoriteBookRepository().listFavoriteBooks();
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

  checkIfBookDownloaded(String filePath) async {
    File file = File(filePath);
    return await file.exists();
  }

}
