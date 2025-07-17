
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gutendex_books_app/presentation/bindings/initial_binding.dart';
import 'package:gutendex_books_app/presentation/pages/book_list_page.dart';
import 'package:gutendex_books_app/presentation/pages/category_selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gutendex Books App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: InitialBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const CategorySelectionPage(), binding: InitialBinding()),
        GetPage(name: '/books', page: () => const BookListPage(), binding: InitialBinding()),
      ],
    );
  }
}
