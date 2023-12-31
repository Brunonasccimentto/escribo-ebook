import 'package:escribo_ebook/model/book/book.dart';
import 'package:escribo_ebook/view-model/book_viewmodel.dart';
import 'package:escribo_ebook/view-model/system_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookWidget extends StatefulWidget {
  final BookModel book;

  const BookWidget({super.key, required this.book});

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  bool isBookSaved = false;

  @override
  void didChangeDependencies() {
    isSaved();
    super.didChangeDependencies();
  }

  void isSaved() async {
    isBookSaved = await Provider.of<BookViewModel>(context).checkIfBookSaved(widget.book);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookViewModel>(context);
    final systemController = Provider.of<SystemInfoViewModel>(context);

    return Container(        
      alignment: Alignment.center,                     
      child: Column(        
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () async {
                await systemController.downloadBookManager(controller.downloadBook(widget.book.download_url, widget.book.title));
                // var lastBookOpened;
            
                VocsyEpub.setConfig(
                  themeColor: Theme.of(context).primaryColor,
                  identifier: "iosBook",
                  scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                  allowSharing: true,
                  enableTts: true,
                  nightMode: true,
                );
            
                VocsyEpub.locatorStream.listen((locator) {
                  // print('LOCATOR: $locator');
                  // lastBookOpened = locator;
                });
                
                VocsyEpub.open(controller.bookApiFilePathResponse);
              },
              child: Image.network(widget.book.cover_url,            
                width: 100,
                height: 130,
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(
              top: -15,  
              right: -15,          
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isBookSaved ? 
                    Icons.bookmark : 
                    Icons.bookmark_add_outlined , 
                    color: Theme.of(context).hintColor
                  ), 
                  onPressed: () { 
                    isBookSaved ? 
                    controller.removeBook(widget.book) : 
                    controller.saveBook(widget.book);
                  }
                ),
              )
            )
          ],
        ),
    
        Text(widget.book.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12
        )),
        Text(widget.book.author),
        
      ]),
    );
  }
}