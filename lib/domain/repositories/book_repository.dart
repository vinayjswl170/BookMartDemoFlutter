
import 'package:gutendex_books_app/domain/models/api_response.dart';

abstract class BookRepository {
  Future<ApiResponse> getBooks({
    String? topic,
    String? search,
    String? mimeType,
    String? nextUrl,
  });
}
