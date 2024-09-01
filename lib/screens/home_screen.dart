// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Management'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.search);
            },
            child: const Text('Search for Books'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addEditBook);
            },
            child: const Text('Add New Book'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.showAuthors);
            },
            child: const Text('Show All Authors'),
          ),
        ],
      ),
    );
  }
}
