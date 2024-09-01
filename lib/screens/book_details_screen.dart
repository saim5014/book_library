// lib/screens/book_details_screen.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:library_database/routes/routes.dart';
import '../helpers/database_helper.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final book =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.addEditBook,
                arguments: book,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await DatabaseHelper.instance.deleteBook(book['id']);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Title: ${book['title']}',
                style: const TextStyle(fontSize: 20)),
            Text('Author ID: ${book['author_id']}'),
            Text('Pages: ${book['pages']}'),
          ],
        ),
      ),
    );
  }
}
