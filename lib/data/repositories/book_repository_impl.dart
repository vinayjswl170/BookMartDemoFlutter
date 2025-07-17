
import 'package:gutendex_books_app/data/api/gutendex_api_client.dart';
import 'package:gutendex_books_app/domain/models/api_response.dart';
import 'package:gutendex_books_app/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final GutendexApiClient apiClient;

  BookRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse> getBooks({
    String? topic,
    String? search,
    String? mimeType,
    String? nextUrl,
  }) async {
    try {
      final responseData = await apiClient.getBooks(
        topic: topic,
        search: search,
        mimeType: mimeType,
        nextUrl: nextUrl,
      );
      return ApiResponse.fromJson(responseData);
    } catch (e) {
      rethrow; // Re-throw the exception to be handled by the presentation layer
    }
  }
}
