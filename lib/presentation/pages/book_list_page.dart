
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

    // Determine crossAxisCount based on screen width
    int crossAxisCount = 2; // Default for smaller screens
    if (screenWidth > 400 && screenWidth <= 600) {
      crossAxisCount = 3;
    } else if (screenWidth > 600 && screenWidth <= 900) {
      crossAxisCount = 4;
    } else if (screenWidth > 900) {
      crossAxisCount = 5; // For very large screens/web
    }

    // Calculate childAspectRatio based on fixed item width (90+padding) and height (140+text height+padding)
    // Rough estimation: card width ~114, card height ~ (140 + 8 + 2*12 + 4) = ~186
    // childAspectRatio = effectiveItemWidth / effectiveItemHeight
    // Let's go with a fixed aspect ratio that looks good for the screenshot's proportions
    final double childAspectRatio = 0.6; // Adjusted for cover + 2 lines of text below

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight, // White background
        foregroundColor: AppColors.primary, // Purple icon and text
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.currentTopic != null
              ? '${controller.currentTopic}'
              : 'All Books',
          style: textTheme.displayMedium?.copyWith(color: AppColors.primary), // Heading 2 style for title
        ),
        centerTitle: false, // Align title to left as per screenshot
        elevation: 0, // No shadow
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onSubmitted: (query) => controller.searchBooks(query),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: AppColors.greyMedium),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.greyLight, // Search bar background color
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.greyMedium), // 16px Regular for hint
              ),
              style: textTheme.bodyLarge, // 16px Regular for input text
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.books.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.books.isEmpty && !controller.isLoading.value) {
                return Center(child: Text('No books found.', style: textTheme.bodyLarge));
              } else {
                return GridView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(16.0), // Padding around the grid
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0, // Spacing between columns
                    mainAxisSpacing: 16.0, // Spacing between rows
                    childAspectRatio: childAspectRatio, // Use calculated aspect ratio
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
