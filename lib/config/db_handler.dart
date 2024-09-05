import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../models/notes.dart';

class DbHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, createdAt TEXT NOT NULL, description TEXT NOT NULL)");
  }

  Future<Notes> insert(Notes notes) async {
    var dbClient = await db;
    await dbClient?.insert('notes', notes.toJson());
    return notes;
  }

  Future<List<Notes>> getNotes() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('notes');
    return queryResult.map((e) => Notes.fromJson(e)).toList();
  }


  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'notes', // Table name
      where: 'id = ?', // Condition
      whereArgs: [id], // Arguments
    );
  }
}
