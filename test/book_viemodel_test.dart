import 'package:escribo_ebook/services/services.dart';
import 'package:escribo_ebook/view-model/book_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final viewmodel = BookViewModel(mainServices: MainServices());
class BookViewModelMock extends Mock implements BookViewModel {}

void main(){
  group('Testes da BookViewModel', () {
    WidgetsFlutterBinding.ensureInitialized();
    test('Should return a list of Books', () async {
      await viewmodel.getBookList();

      expect(viewmodel.bookApiResponse, isNotEmpty);
    });
  });
}