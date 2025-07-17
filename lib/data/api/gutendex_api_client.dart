
import 'package:dio/dio.dart';

class GutendexApiClient {
  final Dio _dio;
  final String _baseUrl = 'http://skunkworks.ignitesol.com:8000';

  GutendexApiClient(this._dio);

  Future<Map<String, dynamic>> getBooks({
    String? topic,
    String? search,
    String? mimeType,
    String? nextUrl,
  }) async {
    final Map<String, dynamic> queryParameters = {};

    if (topic != null && topic.isNotEmpty) {
      queryParameters['topic'] = topic;
    }
    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }
    // Always query for books that have a mime_type with images as per caveat.
    // If a specific mimeType is provided, prioritize it, otherwise use image mime type.
    queryParameters['mime_type'] = mimeType ?? 'image';

    try {
      final Response response;
      if (nextUrl != null && nextUrl.isNotEmpty) {
        // If nextUrl is provided, use it directly for pagination
        response = await _dio.get(nextUrl);
      } else {
        // Otherwise, construct the URL with base path and query parameters
        response = await _dio.get(
          '$_baseUrl/books',
          queryParameters: queryParameters,
        );
      }
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues, bad response)
      throw Exception('Failed to load books: ${e.message}');
    } catch (e) {
      // Handle any other errors
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
