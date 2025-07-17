
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gutendex_books_app/presentation/bindings/initial_binding.dart';
import 'package:gutendex_books_app/presentation/pages/book_list_page.dart';
import 'package:gutendex_books_app/presentation/pages/category_selection_page.dart';
import 'package:gutendex_books_app/utils/app_theme.dart';
import 'package:gutendex_books_app/localization/app_translations.dart'; // Import AppTranslations

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'app_title'.tr, // Localized app title
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      initialRoute: '/',
      translations: AppTranslations(), // Register your translations
      locale: const Locale('en', 'US'), // Default locale
      fallbackLocale: const Locale('en', 'US'), // Fallback if current locale not found
      getPages: [
        GetPage(name: '/', page: () => const CategorySelectionPage(), binding: InitialBinding()),
        GetPage(name: '/books', page: () => const BookListPage(), binding: InitialBinding()),
      ],
    );
  }
}
