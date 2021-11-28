import 'dart:html';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String dbname) async {
    // get the path to save the database at
    final dbpath = await getDatabasesPath();
    // join the above path with the name of the database to get the full_path
    final full_path = await join(dbpath, dbname);

    return await openDatabase(full_path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {

  }

  Future close() async {
    final db = await instance.database;
    
    db.close();
  }
}