import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskmanagement/models/task.dart';

class DatabaseService {
  static Database? _db;

  final String _taskTableName = 'tasks';

  Future<Database> get database async => _db ??= await initSQLiteDatabase();

  Future<Database> initSQLiteDatabase() async {
    String path = await getDatabasesPath();
    final databasePath = join(path, 'my_task.db');
    return openDatabase(
      databasePath,
      onCreate: _createDb,
      version: 1,
    );
  }

  FutureOr<void> _createDb(Database db, int version) {
    db.execute('''
      CREATE TABLE $_taskTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        dueDate TEXT,
        isCompleted INTEGER,
        updatedAt TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<List<Task>> getTasks() async {
    List<Map<String, dynamic>> tasks = await getAll();
    return List.generate(tasks.length, ((index) => Task.fromMap(tasks[index])));
  }

  Future add(Task data) async {
    final db = await database;
    return db.insert(
        _taskTableName,
        {
          'title': data.title,
          'description': data.description,
          'dueDate': data.dueDate.toIso8601String(),
          'isCompleted': data.isCompleted ? 1 : 0,
          'createdAt': data.createdAt.toIso8601String(),
          'updatedAt': data.updatedAt.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future getAll() async {
    final db = await database;
    return db.query(_taskTableName);
  }

  Future getById(int id) async {
    final db = await database;
    return db.query(_taskTableName, where: 'id = ?', whereArgs: [id]);
  }

  Future update(Task data) async {
    final db = await database;
    return db.update(_taskTableName, data.tomap(),
        where: 'id = ?', whereArgs: [data.id]);
  }

  Future delete(int id) async {
    final db = await database;
    return db.delete(_taskTableName, where: 'id = ?', whereArgs: [id]);
  }

  Future deleteAll() async {
    final db = await database;
    return db.delete(_taskTableName);
  }
}
