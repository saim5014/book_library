// lib/screens/show_authors_screen.dart
// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:library_database/routes/routes.dart';
import '../helpers/database_helper.dart';

class ShowAuthorsScreen extends StatefulWidget {
  const ShowAuthorsScreen({super.key});

  @override
  _ShowAuthorsScreenState createState() => _ShowAuthorsScreenState();
}

class _ShowAuthorsScreenState extends State<ShowAuthorsScreen> {
  List<Map<String, dynamic>> _authors = [];

  @override
  void initState() {
    super.initState();
    _loadAuthors();
  }

  Future<void> _loadAuthors() async {
    final authors = await DatabaseHelper.instance.readAuthors();
    setState(() {
      _authors = authors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Authors'),
      ),
      body: ListView.builder(
        itemCount: _authors.length,
        itemBuilder: (context, index) {
          final author = _authors[index];
          return ListTile(
            title: Text(author['name']),
            subtitle: Text(author['bio'] ?? ''),
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.addEditAuthor,
                arguments: author,
              );
            },
          );
        },
      ),
    );
  }
}
