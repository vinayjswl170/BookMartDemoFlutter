
import 'package:gutendex_books_app/domain/models/book.dart';

class ApiResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Book> results;

  ApiResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: List<Book>.from(json['results'].map((bookJson) => Book.fromJson(bookJson))),
    );
  }
}
