// lib/routes/routes.dart
import 'package:flutter/material.dart';
import 'package:library_database/screens/showAuthers.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/book_details_screen.dart';
import '../screens/add_edit_book_screen.dart';
import '../screens/add_edit_author_screen.dart';

class Routes {
  static const home = '/';
  static const search = '/search';
  static const bookDetails = '/bookDetails';
  static const addEditBook = '/addEditBook';
  static const addEditAuthor = '/addEditAuthor';
  static const showAuthors = '/showAuthors'; // Added new route
}

final Map<String, WidgetBuilder> routes = {
  Routes.home: (context) => const HomeScreen(),
  Routes.search: (context) => const SearchScreen(),
  Routes.bookDetails: (context) => const BookDetailsScreen(),
  Routes.addEditBook: (context) => const AddEditBookScreen(),
  Routes.addEditAuthor: (context) => const AddEditAuthorScreen(),
  Routes.showAuthors: (context) => const ShowAuthorsScreen(), // Added new route
};
