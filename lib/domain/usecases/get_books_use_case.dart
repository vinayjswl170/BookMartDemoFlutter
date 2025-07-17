
import 'package:gutendex_books_app/domain/models/api_response.dart';
import 'package:gutendex_books_app/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository bookRepository;

  GetBooksUseCase(this.bookRepository);

  Future<ApiResponse> call({
    String? topic,
    String? search,
    String? mimeType,
    String? nextUrl,
  }) async {
    return await bookRepository.getBooks(
      topic: topic,
      search: search,
      mimeType: mimeType,
      nextUrl: nextUrl,
    );
  }
}
