
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySelectionController extends GetxController {
  // List of category keys to iterate over for building UI
  final List<String> categoryKeys = [
    'category_fiction',
    'category_drama',
    'category_humour',
    'category_politics',
    'category_philosophy',
    'category_history',
    'category_adventure',
    'category_romance',
    'category_science',
    'category_fantasy',
    'category_mystery',
    'category_thriller',
    'category_horror',
    'category_biography',
    'category_religion',
    'category_children',
  ];

  // Map category keys to their SVG asset paths
  final Map<String, String> categorySvgAssets = {
    'category_fiction': 'assets/images/fiction.svg',
    'category_drama': 'assets/images/drama.svg',
    'category_humour': 'assets/images/humour.svg',
    'category_politics': 'assets/images/politics.svg',
    'category_philosophy': 'assets/images/philosophy.svg',
    'category_history': 'assets/images/history.svg',
    'category_adventure': 'assets/images/adventure.svg',
    'category_romance': 'assets/images/romance.svg',
    'category_science': 'assets/images/science.svg',
    'category_fantasy': 'assets/images/fantasy.svg',
    'category_mystery': 'assets/images/mystery.svg',
    'category_thriller': 'assets/images/thriller.svg',
    'category_horror': 'assets/images/horror.svg',
    'category_biography': 'assets/images/biography.svg',
    'category_religion': 'assets/images/religion.svg',
    'category_children': 'assets/images/children.svg',
  };

  String? getSvgAssetForCategory(String categoryKey) {
    return categorySvgAssets[categoryKey];
  }

  void selectCategory(String categoryKey) {
    // Pass the translated category name to the next page's controller or use a key
    Get.toNamed('/books', arguments: {'category': categoryKey.tr}); // Pass the translated name
  }
}
