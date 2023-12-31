import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/view-model/book_viewmodel.dart';
import 'package:escribo_ebook/view/widgets/app_screen.dart';
import 'package:escribo_ebook/view/widgets/book_widget.dart';
import 'package:escribo_ebook/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void didChangeDependencies() {
    Provider.of<BookViewModel>(context).getFavoritesBookList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<BookModel> favoriteBookList = Provider.of<BookViewModel>(context).favoriteBooks;
 
    return AppScreen(
      appBar: AppBar(
        title: const Text('Favoritos'),       
      ),
      widgets: favoriteBookList.isNotEmpty ? [
        OrientationBuilder(
          builder: (context, orientation) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 2 : 3), 
              itemCount: favoriteBookList.length,
              itemBuilder: (context, index) {
                return BookWidget(book: favoriteBookList[index]);
              });
          }),

        const LoadingIndicator()
      ] : [
        const Text("Nenhum livro adicionado aos seus favoritos")
      ]
    );
  }
}