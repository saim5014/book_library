// lib/helpers/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('library.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Authors (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      bio TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE Books (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      author_id INTEGER,
      pages INTEGER,
      FOREIGN KEY (author_id) REFERENCES Authors(id)
    )
    ''');
  }

  // CRUD Operations for Authors
  Future<int> createAuthor(Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.insert('Authors', values);
  }

  Future<List<Map<String, dynamic>>> readAuthors() async {
    final db = await instance.database;
    return await db.query('Authors');
  }

  Future<int> updateAuthor(Map<String, dynamic> values) async {
    final db = await instance.database;
    final id = values['id'];
    return await db.update('Authors', values, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAuthor(int id) async {
    final db = await instance.database;
    return await db.delete('Authors', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD Operations for Books
  Future<int> createBook(Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.insert('Books', values);
  }

  Future<List<Map<String, dynamic>>> readBooks() async {
    final db = await instance.database;
    return await db.query('Books');
  }

  Future<int> updateBook(Map<String, dynamic> values) async {
    final db = await instance.database;
    final id = values['id'];
    return await db.update('Books', values, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBook(int id) async {
    final db = await instance.database;
    return await db.delete('Books', where: 'id = ?', whereArgs: [id]);
  }
}
