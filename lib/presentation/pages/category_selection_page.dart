
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gutendex_books_app/presentation/controllers/category_selection_controller.dart';

class CategorySelectionPage extends GetView<CategorySelectionController> {
  const CategorySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gutendex Books'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 3 / 1,
          ),
          itemCount: controller.bookCategories.length,
          itemBuilder: (context, index) {
            final category = controller.bookCategories[index];
            return ElevatedButton(
              onPressed: () => controller.selectCategory(category),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                category,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            );
          },
        ),
      ),
    );
  }
}
