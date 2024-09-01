// lib/models/book.dart
class Book {
  final int? id;
  final String title;
  final int authorId;
  final int pages;

  Book({
    this.id,
    required this.title,
    required this.authorId,
    required this.pages,
  });

  // Convert a Book into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author_id': authorId,
      'pages': pages,
    };
  }

  // Extract a Book object from a Map.
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      authorId: map['author_id'],
      pages: map['pages'],
    );
  }
}
