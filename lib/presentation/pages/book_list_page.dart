
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gutendex_books_app/presentation/controllers/book_list_controller.dart';
import 'package:gutendex_books_app/presentation/widgets/book_item_card.dart';
import 'package:gutendex_books_app/utils/app_colors.dart';

class BookListPage extends GetView<BookListController> {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth > 400 && screenWidth <= 600) {
      crossAxisCount = 3;
    } else if (screenWidth > 600 && screenWidth <= 900) {
      crossAxisCount = 4;
    } else if (screenWidth > 900) {
      crossAxisCount = 5;
    }
    final double childAspectRatio = 0.6; // Adjusted for cover + 2 lines of text below

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.currentTopic != null
              ? controller.currentTopic! // currentTopic is already translated string
              : 'all_books_title'.tr,
          style: textTheme.displayMedium?.copyWith(color: AppColors.primary),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onSubmitted: (query) => controller.searchBooks(query),
              decoration: InputDecoration(
                hintText: 'search_hint'.tr,
                prefixIcon: const Icon(Icons.search, color: AppColors.greyMedium),
                hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.greyMedium),
              ),
              style: textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.books.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.books.isEmpty && !controller.isLoading.value) {
                return Center(child: Text('no_books_found'.tr, style: textTheme.bodyLarge));
              } else {
                return GridView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: controller.books.length + (controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.books.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final book = controller.books[index];
                    return BookItemCard(
                      book: book,
                      onTap: () => controller.openBookLink(book),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
