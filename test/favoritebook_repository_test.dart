@Tags(['mobile'])

import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/favorite-book/favorites_book_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FavoriteBookRepositoryMock extends Mock implements FavoriteBookRepository {}

void main() {
  final repository = FavoriteBookRepositoryMock();
  List<BookModel> favoriteBooks = [];
  final BookModel book = BookModel(
    id: 2,
    title: 'Kazan',
    author: "Curwood, James Oliver",
    cover_url: "https://www.gutenberg.org/cache/epub/72127/pg72127.cover.medium.jpg",
    download_url: "https://www.gutenberg.org/ebooks/72127.epub.images"
  );

  test('Should save a book', () async {
    when(()=> repository.addBookOnFavorites(book)).thenAnswer((_) async {
      favoriteBooks.add(book);
    });

    await repository.addBookOnFavorites(book); 

    expect(favoriteBooks, hasLength(1));
    expect(favoriteBooks[0].id, equals(2));
  });

  test('Should delete a book', () async {
    favoriteBooks = [book];

    when(()=> repository.removeBookOnFavorites(book)).thenAnswer((_) async {
      favoriteBooks.remove(book);
    });

    await repository.removeBookOnFavorites(book); 

    expect(favoriteBooks, isEmpty);
  });
}
