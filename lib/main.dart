import 'package:escribo_ebook/view-models/system_info_viewmodel.dart';
import 'package:escribo_ebook/view/favorites/favorites.dart';
import 'package:escribo_ebook/view/homescreen/homepage.dart';
import 'package:escribo_ebook/view-models/book_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BookViewModel()),
        ChangeNotifierProvider.value(value: SystemInfoViewModel())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 236, 236, 236),
                titleTextStyle: TextStyle(
                  color: Color.fromRGBO(150,196,81, 1),
                  fontSize: 20
                )
              ),
              hintColor: const Color.fromRGBO(243, 7, 3, 1),
              primaryColor: const Color.fromRGBO(27,157,255, 1),              
              iconTheme: const IconThemeData(color: Colors.white70),
            ),
            initialRoute: "/",
            routes: {
              "/": (BuildContext context) => const HomeScreen(),
              "/favorites": (BuildContext context) => const FavoritesScreen(),
            }
      ),
    );
  }
}
