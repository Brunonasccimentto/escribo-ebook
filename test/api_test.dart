import 'package:escribo_ebook/model/book/services/api/api.dart';
import 'package:escribo_ebook/model/book/services/api/api_endpoints.dart';
import 'package:escribo_ebook/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'services/mock_services.dart';

void main() {

  late MockServices services;
  late BookApiService? bookApi;
  late BookApiService? realBookApi;

  setUp(() {
    services = MockServices();
    bookApi = BookApiService(services: services);
    realBookApi = BookApiService(services: MainServices());
  });

  //forma correta de ser feita no when deve vir o serviço que esta sendo mockado não o repositório.

  group('http request and response tests', () { 
    test('should return response JSON for valid request', () async {
      String baseUrl = "https://escribo.com/";
      String path = 'fake.json';

      when(() => services.client.get(Uri.parse(baseUrl + path)))
          .thenAnswer((_) async => Response(jsonResponse, 200 ));

      final response = await bookApi?.getResponse(path);

      expect(response, isA<List>());
      expect(response[0]['title'], equals('The Bible of Nature'));
    });

    test('should return a real Response', () async {
      final response = await realBookApi?.getResponse(ApiEndPoints().getBooks);

      expect(response, isA<List>());
      expect(response[0]['title'], equals('The Bible of Nature'));
    });
  });
  

  test('Should get filePath', () async {
    String url = 'https://www.gutenberg.org/ebooks/72127.epub.images';
    String title = 'Kazan';
    String dir = 'fake/dir/0';

    var request = MockHttpClientRequest();
    var response = MockHttpClientResponse();

    when(() => bookApi?.services.httpClient.getUrl(Uri.parse(url)))
        .thenAnswer((_) async => request);

    when(() => request.close())
        .thenAnswer((_) async => response);

    when(() => response.statusCode)
        .thenReturn(200);

    when(() => consolidateHttpClientResponseBytes(response))
        .thenAnswer((_) async => Uint8List(4));

    final res = await bookApi?.getFile(url, title);

    expect(res, equals('$dir/Kazan'));
  }, skip: 'dont now how to mock consolidateHttpClientResponseBytes answer');

  tearDown(() {
    bookApi = null;
    realBookApi = null;
  });
}

const jsonResponse = '''[
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
]''';
