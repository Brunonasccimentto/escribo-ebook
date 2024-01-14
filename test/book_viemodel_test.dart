import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/book_repository.dart';
import 'package:escribo_ebook/model/book/services/api/api.dart';
import 'package:escribo_ebook/view-model/book_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'services/mock_services.dart';

class MockBookRepository extends Mock implements BookRepository{
  @override
  final BookApiService bookApi;

  MockBookRepository({required this.bookApi});
}

void main(){

  late BookViewModel? viewmodel;
  late BookRepository? repository;

  setUp(() {
    repository = MockBookRepository(bookApi: BookApiService(services: MockServices()));
    viewmodel = BookViewModel(repository: repository!);
  });

  group('Testes da BookViewModel', () {
    test('Should return a list of Books', () async {
      List<BookModel> fakebooks = jsonResponse.map((json) => BookModel.fromJson(json)).toList();

      when(() => repository?.listBooks())
          .thenAnswer((_) async => fakebooks);

      await viewmodel?.getBookList();
      expect(viewmodel?.bookApiResponse, fakebooks);
    });
  });

  group('downloadbook tests', () { 

    test('should return a pathfile book', () async {
      String url = 'https://www.gutenberg.org/ebooks/72127.epub.images';
      String filename= 'Kazan';
      String pathfile = '${repository?.bookApi.services.directory}/$filename';

      when(() => repository?.fetchFile(url, filename))
            .thenAnswer((_) async => pathfile);

      await viewmodel?.downloadBook(url, filename);
    
      expect(viewmodel?.bookApiFilePathResponse, equals(pathfile));
    });
  });

  tearDown(() {
    repository = null;
    viewmodel = null;
  });
}

const List jsonResponse = [
  {
    "id": 1,
    "title": "The Bible of Nature",
    "author": "Oswald, Felix L.",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72134.epub3.images"
  },
  {
    "id": 2,
    "title": "Kazan",
    "author": "Curwood, James Oliver",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72127/pg72127.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72127.epub.images"
  },
  {
    "id": 3,
    "title": "Mythen en sagen uit West-Indië",
    "author": "Cappelle, Herman van, Jr.",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72126/pg72126.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72126.epub.noimages"
  },
  {
    "id": 4,
    "title": "Lupe",
    "author": "Affonso Celso",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/63606.epub3.images"
  },
  {
    "id": 4,
    "title": "Lupe",
    "author": "Affonso Celso",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/63606.epub3.images"
  },
  {
    "id": 5,
    "title": "Nuorta ja vanhaa väkeä: Kokoelma kertoelmia",
    "author": "Fredrik Nycander",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72135/pg72135.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72135.epub3.images"
  },
  {
    "id": 6,
    "title": "Among the Mushrooms: A Guide For Beginners",
    "author": "Burgin and Dallas",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/18452/pg18452.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/18452.epub3.images"
  },
  {
    "id": 7,
    "title": "The History of England in Three Volumes, Vol.III.",
    "author": "Edward Farr and E. H. Nolan",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/19218/pg19218.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/19218.epub3.images"
  },
  {
    "id": 8,
    "title": "Adventures of Huckleberry Finn",
    "author": "Mark Twain",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/76/pg76.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/76.epub3.images"
  },
  {
    "id": 9,
    "title": "The octopus: or, The 'devil-fish' of fiction and of fact",
    "author": "Henry Lee",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72133/pg72133.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72133.epub3.images"
  }
];

