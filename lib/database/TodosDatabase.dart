import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodosDatabase {
  static final TodosDatabase instance = TodosDatabase._init();

  static Database? _database;

  TodosDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('todos.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, filePath);

    var db = await openDatabase(path,
        version: 1, onCreate: _createDb, onConfigure: _onConfigure);
    return db;
  }

  Future _createDb(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('''
        CREATE TABLE todo(
          _id INTEGER PRIMARY KEY AUTOINCREMENT,
          _title TEXT NOT NULL,
          _date_created TEXT,
          _is_active INTEGER
        )''');

      await txn.execute('''
        CREATE TABLE category(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        _name TEXT NOT NULL
        )''');

      await txn.execute('''
        CREATE TABLE todos_category(
          todo_id INTEGER,
          category_id INTEGER,
          FOREIGN KEY(todo_id) REFERENCES todo(_id) ON DELETE CASCADE ON UPDATE CASCADE,
          FOREIGN KEY(category_id) REFERENCES category(_id) ON DELETE CASCADE ON UPDATE CASCADE
        )''');
    });

    await db.insert('category', {'_name': 'Personal'});
    await db.insert('category', {'_name': 'Bussiness'});
    await db.insert('category', {'_name': 'Study'});
    await db.insert('category', {'_name': 'Sport'});
    await db.insert('category', {'_name': 'Work'});
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
