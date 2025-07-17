
import 'package:get/get.dart';

class CategorySelectionController extends GetxController {
  final List<String> bookCategories = [
    'Fiction',
    'Drama',
    'Humor',
    'Poetry',
    'Romance',
    'Adventure',
    'Children',
    'History',
    'Science',
    'Fantasy',
    'Mystery',
    'Thriller',
    'Horror',
    'Biography',
    'Philosophy',
    'Religion',
  ];

  void selectCategory(String category) {
    // Navigate to the book list page with the selected category
    Get.toNamed('/books', arguments: {'category': category});
  }
}
