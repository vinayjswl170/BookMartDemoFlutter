
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gutendex_books_app/domain/models/book.dart';
import 'package:gutendex_books_app/domain/usecases/get_books_use_case.dart';

class BookListController extends GetxController {
  final GetBooksUseCase getBooksUseCase;
  final ScrollController scrollController = ScrollController();

  BookListController(this.getBooksUseCase);

  final RxList<Book> books = <Book>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  String? nextUrl;
  String? currentTopic; // This will now hold the translated category name
  String? currentSearchQuery;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['category'] != null) {
      currentTopic = Get.arguments['category'] as String; // Already translated string
      fetchBooks();
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading.value &&
          hasMore.value) {
        fetchBooks();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchBooks({bool isNewSearch = false}) async {
    if (isLoading.value || (!hasMore.value && !isNewSearch)) return;

    isLoading.value = true;
    try {
      final response = await getBooksUseCase.call(
        topic: currentTopic, // This is already the translated string received from previous page
        search: currentSearchQuery,
        mimeType: 'image',
        nextUrl: isNewSearch ? null : nextUrl,
      );

      if (isNewSearch) {
        books.clear();
      }
      books.addAll(response.results);
      nextUrl = response.next;
      hasMore.value = response.next != null;
    } catch (e) {
      Get.snackbar('error'.tr, 'failed_to_load_books'.tr + e.toString()); // Localized error message
    } finally {
      isLoading.value = false;
    }
  }

  void searchBooks(String query) {
    currentSearchQuery = query;
    hasMore.value = true;
    nextUrl = null;
    fetchBooks(isNewSearch: true);
  }

  Future<void> openBookLink(Book book) async {
    String? viewableUrl;
    if (book.formats.containsKey('text/html')) {
      viewableUrl = book.formats['text/html'];
    } else if (book.formats.containsKey('application/pdf')) {
      viewableUrl = book.formats['application/pdf'];
    } else if (book.formats.containsKey('text/plain; charset=utf-8')) {
      viewableUrl = book.formats['text/plain; charset=utf-8'];
    } else if (book.formats.containsKey('text/plain')) {
      viewableUrl = book.formats['text/plain'];
    }

    if (viewableUrl != null && !viewableUrl.endsWith('.zip')) {
      final Uri uri = Uri.parse(viewableUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        Get.snackbar('error'.tr, 'could_not_launch_url'.tr + viewableUrl); // Localized error message
      }
    } else {
      Get.defaultDialog(
        title: 'error'.tr,
        middleText: 'no_viewable_version_available'.tr,
      );
    }
  }
}
