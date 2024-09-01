// lib/models/author.dart
class Author {
  final int? id;
  final String name;
  final String? bio;

  Author({
    this.id,
    required this.name,
    this.bio,
  });

  // Convert an Author into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
    };
  }

  // Extract an Author object from a Map.
  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: map['id'],
      name: map['name'],
      bio: map['bio'],
    );
  }
}
