import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/view-model/book_viewmodel.dart';
import 'package:escribo_ebook/view/widgets/app_screen.dart';
import 'package:escribo_ebook/view/widgets/book_widget.dart';
import 'package:escribo_ebook/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void didChangeDependencies() {
    Provider.of<BookViewModel>(context).getBookList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<BookModel> bookList = Provider.of<BookViewModel>(context).bookApiResponse;
    
    return AppScreen(
      appBar: AppBar(
        title: Row(        
          children: [
            Image.asset('assets/icone-Escribo.png', 
              width: 40, 
              height: 40,
            ),
            const SizedBox(width: 12),
            const Text('Livros'),
          ],
        ),
        actions: [         
          TextButton.icon(
            label: Text('Favoritos', 
            style: TextStyle(
              color: Theme.of(context).appBarTheme.titleTextStyle!.color
            )),
            icon: Icon(Icons.favorite, color: Theme.of(context).hintColor), 
            onPressed: () { 
              Navigator.of(context).pushNamed('/favorites');
            }, 
          )   
        ]),
      widgets: [
        OrientationBuilder(
          builder: (context, orientation) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 2 : 3), 
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                return BookWidget(book: bookList[index]);
              });
          }),

        const LoadingIndicator()
      ]
    );
  }
}


