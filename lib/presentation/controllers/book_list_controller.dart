
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
  String? currentTopic;
  String? currentSearchQuery;

  @override
  void onInit() {
    super.onInit();
    // Get the category passed from the previous page
    if (Get.arguments != null && Get.arguments['category'] != null) {
      currentTopic = Get.arguments['category'];
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
        topic: currentTopic,
        search: currentSearchQuery,
        mimeType: 'image', // Always filter by image mime type as per requirement
        nextUrl: isNewSearch ? null : nextUrl,
      );

      if (isNewSearch) {
        books.clear();
      }
      books.addAll(response.results);
      nextUrl = response.next;
      hasMore.value = response.next != null;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchBooks(String query) {
    currentSearchQuery = query;
    hasMore.value = true; // Reset hasMore for new search
    nextUrl = null; // Reset nextUrl for new search
    fetchBooks(isNewSearch: true);
  }

  Future<void> openBookLink(Book book) async {
    String? viewableUrl;
    // Prioritize HTML, then PDF, then TXT
    if (book.formats.containsKey('text/html')) {
      viewableUrl = book.formats['text/html'];
    } else if (book.formats.containsKey('application/pdf')) {
      viewableUrl = book.formats['application/pdf'];
    } else if (book.formats.containsKey('text/plain; charset=utf-8')) {
      viewableUrl = book.formats['text/plain; charset=utf-8'];
    } else if (book.formats.containsKey('text/plain')) {
      viewableUrl = book.formats['text/plain'];
    }

    // Caveat 1: Zip files are NOT viewable files.
    if (viewableUrl != null && !viewableUrl.endsWith('.zip')) {
      if (await canLaunchUrl(Uri.parse(viewableUrl))) {
        await launchUrl(Uri.parse(viewableUrl));
      } else {
        Get.snackbar('Error', 'Could not launch $viewableUrl');
      }
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'No viewable version available',
      );
    }
  }
}
