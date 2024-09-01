// lib/screens/add_edit_book_screen.dart
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class AddEditBookScreen extends StatefulWidget {
  const AddEditBookScreen({super.key});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  int authorId = 0;
  int pages = 0;
  bool isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final book =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (book != null) {
      title = book['title'];
      authorId = book['authorId'];
      pages = book['pages'];
      isEditing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Book' : 'Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Please enter a title' : null,
                onSaved: (val) => title = val!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: authorId.toString(),
                decoration: const InputDecoration(
                  labelText: 'Author ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter an author ID'
                    : null,
                onSaved: (val) => authorId = int.parse(val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: pages.toString(),
                decoration: const InputDecoration(
                  labelText: 'Pages',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter the number of pages'
                    : null,
                onSaved: (val) => pages = int.parse(val!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final bookData = {
                      'title': title,
                      'author_id': authorId,
                      'pages': pages,
                    };
                    if (isEditing) {
                      // Update existing book
                      await DatabaseHelper.instance.updateBook({
                        'id': bookData['id'], // Assuming you have the book ID
                        ...bookData,
                      });
                    } else {
                      // Create new book
                      await DatabaseHelper.instance.createBook(bookData);
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(isEditing ? 'Update Book' : 'Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
