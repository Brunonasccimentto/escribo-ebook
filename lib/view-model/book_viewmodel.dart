import 'dart:io';
import 'package:escribo_ebook/interfaces/mainservices.dart';
import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/book_repository.dart';
import 'package:escribo_ebook/model/book/services/api/api.dart';
import 'package:escribo_ebook/shared/enums/loading.dart';
import 'package:flutter/material.dart';

class BookViewModel extends ChangeNotifier {
  final IMainServices mainServices;

  BookViewModel({required this.mainServices});

  List<BookModel> _bookApiResponse = [];

  get bookApiResponse {
    return _bookApiResponse;
  }

  Future<void> getBookList() async {
    try {
      List<BookModel> bookList = await BookRepository(bookApi: BookApiService(client: mainServices.clientInst())).listBooks();
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
    Directory dir = await mainServices.dirInst();
    String filePath = '${dir.path}/$filename.epub';
    bool thisBookIsDownloaded = await checkIfBookDownloaded(filePath);

    if(thisBookIsDownloaded) {
      loading = Status.alreadyDownloaded;
      notifyListeners();

      _bookApiFilePathResponse = filePath;
      
    } else {
      loading = Status.loading;
      notifyListeners();

      String newfilePath = await BookRepository(
              bookApi: BookApiService(
                directory: mainServices.dirInst(),
                httpClient: mainServices.httpclientInst(),
                file: mainServices.fileInst()))
          .fetchFile(url, filename);
          
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
