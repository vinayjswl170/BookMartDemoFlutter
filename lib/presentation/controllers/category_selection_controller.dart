
import 'package:flutter/material.dart'; // Keep this import as Icons are still used indirectly for default
import 'package:get/get.dart';

class CategorySelectionController extends GetxController {
  final List<String> bookCategories = [
    'Fiction',
    'Drama',
    'Humour',
    'Politics',
    'Philosophy',
    'History',
    'Adventure',
    'Romance',
    'Science',
    'Fantasy',
    'Mystery',
    'Thriller',
    'Horror',
    'Biography',
    'Religion',
    'Children',
  ];

  // Map category names to their SVG asset paths
  final Map<String, String> categorySvgAssets = {
    'Fiction': 'assets/images/fiction.svg',
    'Drama': 'assets/images/drama.svg',
    'Humour': 'assets/images/humour.svg',
    'Politics': 'assets/images/politics.svg',
    'Philosophy': 'assets/images/philosophy.svg',
    'History': 'assets/images/history.svg',
    'Adventure': 'assets/images/adventure.svg',
    'Romance': 'assets/images/romance.svg',
    'Science': 'assets/images/science.svg',
    'Fantasy': 'assets/images/fantasy.svg',
    'Mystery': 'assets/images/mystery.svg',
    'Thriller': 'assets/images/thriller.svg',
    'Horror': 'assets/images/horror.svg',
    'Biography': 'assets/images/biography.svg',
    'Religion': 'assets/images/religion.svg',
    'Children': 'assets/images/children.svg',
  };

  String? getSvgAssetForCategory(String category) {
    return categorySvgAssets[category]; // Returns null if not found
  }

  void selectCategory(String category) {
    Get.toNamed('/books', arguments: {'category': category});
  }
}
