
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:gutendex_books_app/data/api/gutendex_api_client.dart';
import 'package:gutendex_books_app/data/repositories/book_repository_impl.dart';
import 'package:gutendex_books_app/domain/repositories/book_repository.dart';
import 'package:gutendex_books_app/domain/usecases/get_books_use_case.dart';
import 'package:gutendex_books_app/presentation/controllers/category_selection_controller.dart';
import 'package:gutendex_books_app/presentation/controllers/book_list_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Register Dio
    Get.lazyPut<Dio>(() => Dio());

    // Register API Client
    Get.lazyPut<GutendexApiClient>(() => GutendexApiClient(Get.find<Dio>()));

    // Register Repositories
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find<GutendexApiClient>()));

    // Register Use Cases
    Get.lazyPut<GetBooksUseCase>(() => GetBooksUseCase(Get.find<BookRepository>()));

    // Register Controllers
    Get.lazyPut<CategorySelectionController>(() => CategorySelectionController());
    Get.lazyPut<BookListController>(() => BookListController(Get.find<GetBooksUseCase>()));
  }
}
