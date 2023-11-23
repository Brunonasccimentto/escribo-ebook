import 'package:isar/isar.dart';
part 'book.g.dart';

@Collection()
class BookModel {
  late Id id;
  late String title;
  late String author;
  late String cover_url;
  late String download_url;

  BookModel({
    required this.id,
    required this.title, 
    required this.author, 
    required this.cover_url, 
    required this.download_url
  });

   BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    cover_url = json['cover_url'];
    download_url = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['cover_url'] = this.download_url;
    data['download_url'] = this.download_url;
    return data;
  }
}

