import 'dart:io';
import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/book_repository.dart';
import 'package:escribo_ebook/services/services.dart';
import 'package:escribo_ebook/shared/enums/loading.dart';
import 'package:flutter/material.dart';

class BookViewModel extends ChangeNotifier {
  final BookRepository repository;

  BookViewModel({ required this.repository});

  List<BookModel> _bookApiResponse = [];

  get bookApiResponse {
    return _bookApiResponse;
  }

  Future<void> getBookList() async {
    try {
      List<BookModel> bookList = await repository.listBooks();
      _bookApiResponse = bookList;
    } catch (e) {
      _bookApiResponse = [];
    }
    
    notifyListeners();
  }

  String _bookApiFilePathResponse = '';
  Status loading = Status.completed;

  get bookApiFilePathResponse {
    return _bookApiFilePathResponse;
  }

  Future<void> downloadBook(String url, String filename) async {
    Directory dir = await MainServices().directory;
    String filePath = '$dir/$filename.epub';
    bool thisBookIsDownloaded = await checkIfBookDownloaded(filePath);
  

    if(thisBookIsDownloaded) {
      loading = Status.alreadyDownloaded;
      notifyListeners();

      _bookApiFilePathResponse = filePath;
      
    } else {
      loading = Status.loading;
      notifyListeners();

      String newfilePath = await repository.fetchFile(url, filename);
          
      _bookApiFilePathResponse = newfilePath;
    }

    loading = Status.completed;
    notifyListeners();
  }

  Future<bool> checkIfBookDownloaded(String filePath) async {
    File file = File(filePath);
    return await file.exists();
  }
}
