
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gutendex_books_app/presentation/controllers/book_list_controller.dart';

class BookListPage extends GetView<BookListController> {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.currentTopic != null
            ? '${controller.currentTopic} Books'
            : 'All Books'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (query) => controller.searchBooks(query),
              decoration: InputDecoration(
                hintText: 'Search by title or author...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.books.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.books.isEmpty && !controller.isLoading.value) {
                return const Center(child: Text('No books found.'));
              } else {
                return ListView.builder(
                  controller: ScrollController()
                    ..addListener(() {
                      if (controller.isLoading.isFalse &&
                          controller.hasMore.isTrue &&
                          ScrollController().position.pixels ==
                              ScrollController().position.maxScrollExtent) {
                        controller.fetchBooks();
                      }
                    }),
                  itemCount: controller.books.length + (controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.books.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final book = controller.books[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        onTap: () => controller.openBookLink(book),
                        leading: (book.formats.containsKey('image/jpeg') &&
                                book.formats['image/jpeg']!.isNotEmpty)
                            ? Image.network(
                                book.formats['image/jpeg']!,
                                width: 50,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.book, size: 50),
                              )
                            : const Icon(Icons.book, size: 50),
                        title: Text(book.title),
                        subtitle: Text(book.authors.join(', ')),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
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
