import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/interface/ibook.dart';
import 'package:escribo_ebook/model/book/interface/ifavoritebooks.dart';
import 'package:escribo_ebook/model/book/services/api/api.dart';
import 'package:escribo_ebook/model/book/services/database/database.dart';
import 'package:isar/isar.dart';

class FavoriteBookRepository extends IbookRepository implements IfavoriteBooks {
  final BookApiService bookApi;
  final DatabaseService database;

  FavoriteBookRepository({required this.bookApi, required this.database});

  @override
  Future<List<BookModel>> listBooks() async {
    final isarDB = await database.openDB();   
    return await isarDB.bookModels.where().findAll();
  }

  @override
  Future<String> fetchFile(String url, String filename) async {
    String response = await bookApi.getFile(url, filename);
    return response;
  }
  
  @override
  Future<void> addBookOnFavorites(BookModel book) async {
    final isarDB = await database.openDB();
    
    await isarDB.writeTxn(() async {
      await isarDB.bookModels.put(book);
    });
  }

  @override
  Future<void> removeBookOnFavorites(BookModel book) async {
    final isarDB = await database.openDB();
    
    await isarDB.writeTxn(() async {
      await isarDB.bookModels.delete(book.id);
    });
  }

  @override
  Future<bool> isBookSaved(BookModel book) async {
    final isarDB = await database.openDB();   
    final isBookSaved = await isarDB.bookModels.filter().idEqualTo(book.id).findFirst();
    if(isBookSaved != null){
      return true;
    }

    return false;  
  }
  
  
}