// lib/screens/add_edit_author_screen.dart
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class AddEditAuthorScreen extends StatefulWidget {
  const AddEditAuthorScreen({super.key});

  @override
  _AddEditAuthorScreenState createState() => _AddEditAuthorScreenState();
}

class _AddEditAuthorScreenState extends State<AddEditAuthorScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String bio = '';
  bool isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final author =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (author != null) {
      name = author['name'];
      bio = author['bio'] ?? '';
      isEditing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Author' : 'Add New Author'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Please enter a name' : null,
                onSaved: (val) => name = val!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: bio,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => bio = val!,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final authorData = {
                      'name': name,
                      'bio': bio,
                    };
                    if (isEditing) {
                      // Update existing author
                      final id = (ModalRoute.of(context)!.settings.arguments
                          as Map<String, dynamic>)['id'];
                      await DatabaseHelper.instance.updateAuthor({
                        'id': id,
                        ...authorData,
                      });
                    } else {
                      // Create new author
                      await DatabaseHelper.instance.createAuthor(authorData);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? 'Update Author' : 'Add Author'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
