
class Book {
  final int id;
  final String title;
  final List<String> authors;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final String? mediaType;
  final Map<String, String> formats;
  final int downloadCount;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: List<String>.from(json['authors'].map((author) => author['name'])),
      subjects: List<String>.from(json['subjects']),
      bookshelves: List<String>.from(json['bookshelves']),
      languages: List<String>.from(json['languages']),
      mediaType: json['media_type'] as String?,
      formats: Map<String, String>.from(json['formats']),
      downloadCount: json['download_count'] as int,
    );
  }
}
