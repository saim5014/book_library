// lib/screens/search_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:library_database/routes/routes.dart';
import '../helpers/database_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _searchBooks(String query) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'Books',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by title',
                border: OutlineInputBorder(),
              ),
              onChanged: _searchBooks,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final book = _searchResults[index];
                return ListTile(
                  title: Text(book['title']),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.bookDetails,
                      arguments: book,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
