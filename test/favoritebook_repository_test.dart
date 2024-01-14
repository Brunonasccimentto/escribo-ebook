@Tags(['mobile'])

import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/favorite-book/favorites_book_repository.dart';
import 'package:escribo_ebook/model/book/services/api/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'services/mock_services.dart';

void main() {
  final repository = FavoriteBookRepository(bookApi: BookApiService(services: MockServices()), database: MockIsarDB());
  
  final BookModel book = BookModel(
    id: 2,
    title: 'Kazan',
    author: "Curwood, James Oliver",
    cover_url: "https://www.gutenberg.org/cache/epub/72127/pg72127.cover.medium.jpg",
    download_url: "https://www.gutenberg.org/ebooks/72127.epub.images"
  );

  test('Should return a list of books', () async {
    final isar = MockIsar();
    final collection = MockIsarCollection();
    final query = MockQueryBuilder();

    when(() => repository.database.openDB())
        .thenAnswer((_) async => isar);

    when(() => isar.bookModels).thenReturn(collection);

    when(() => collection.where().findAll())
        .thenAnswer((_) async => isar.mockBooks);
    
    verify(() => collection.where().findAll()).called(1);
    final list = await repository.listBooks();

    expect(list, isEmpty);
  }, skip: 'I dont now how to mock database');

  test('Should delete a book', () async {

  });
}
