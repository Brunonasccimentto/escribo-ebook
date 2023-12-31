import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/model/book/services/database/database.dart';
import 'package:isar/isar.dart';

class FavoriteBookRepository {
  final database = DatabaseService();
  
  Future<void> addBookOnFavorites(BookModel book) async {
    final isarDB = await database.openDB();
    
    await isarDB.writeTxn(() async {
      await isarDB.bookModels.put(book);
    });
  }

  Future<void> removeBookOnFavorites(BookModel book) async {
    final isarDB = await database.openDB();
    
    await isarDB.writeTxn(() async {
      await isarDB.bookModels.delete(book.id);
    });
  }

  Future<List<BookModel>> listFavoriteBooks() async {
    final isarDB = await database.openDB();   
    return await isarDB.bookModels.where().findAll();
  }

  Future<bool> isBookSaved(BookModel book) async {
    final isarDB = await database.openDB();   
    final isBookSaved = await isarDB.bookModels.filter().idEqualTo(book.id).findFirst();
    if(isBookSaved != null){
      return true;
    }

    return false;  
  }
}