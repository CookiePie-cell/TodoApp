import 'dart:developer';

import 'package:todo_app/database/TodosDatabase.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/models/todo.dart';

class TodosDao {
  final TodosDatabase todosDatabase = TodosDatabase.instance;

// TODO: revisi addTodo
  Future addTodo(Todo todo) async {
    final db = await todosDatabase.database;
    await db.transaction((txn) async {
      int id2 = await txn.insert('todo', todo.toMap());
      int id1 = await txn.rawInsert(
          'INSERT INTO todos_category SELECT last_insert_rowid(), _id FROM category WHERE category._name = ?',
          [todo.category]);
      // int id1 = await txn.rawInsert(
      //     'INSERT INTO todos_category VALUES(last_insert_rowid(), ?)',
      //     [categoryId]);
      // int changes = await txn.rawUpdate(
      //     'UPDATE category SET _task_count = _task_count + 1 WHERE _id = ?',
      //     [categoryId]);
    });
  }

  Future<Todo?> getTodo(int id) async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.query('todo',
        columns: ['_id', '_title', '_date_created', '_is_active'],
        where: '_id = ?',
        whereArgs: [id]);
    return result.isNotEmpty ? Todo.fromMap(result.first) : null;
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT todo._id, todo._title, category._name AS _category, todo._date_created, todo._is_active FROM todo
        INNER JOIN todos_category ON todo._id = todos_category.todo_id
        INNER JOIN category ON todos_category.category_id = category._id
        GROUP BY _date_created''');
    return result.isNotEmpty
        ? result.map((item) => Todo.fromMap(item)).toList()
        : [];
  }

  Future<List<Todo>> getTodosByCategory(int id) async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT todo._id, todo._title, category._name AS _category, todo._date_created, todo._is_active FROM todo
        INNER JOIN todos_category ON todo._id = todos_category.todo_id
        INNER JOIN category ON todos_category.category_id = category._id
        WHERE category._id = ? GROUP BY _date_created''', [id]);
    // log(result.toString());
    return result.isNotEmpty
        ? result.map((item) => Todo.fromMap(item)).toList()
        : [];
  }

  Future updateTodo(Todo todo) async {
    final db = await todosDatabase.database;
    log(todo.toMap().toString());
    await db.transaction((txn) async {
      await txn
          .update('todo', todo.toMap(), where: '_id = ?', whereArgs: [todo.id]);
      await txn.rawUpdate(
          'UPDATE todos_category SET category_id = (SELECT _id FROM category WHERE _name = ?) WHERE todo_id = ?',
          [todo.category, todo.id]);
    });
    // return db
    //     .update('todo', todo.toMap(), where: '_id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(Todo todo) async {
    final db = await todosDatabase.database;
    return await db.delete('todo', where: '_id = ?', whereArgs: [todo.id]);
  }

  Future<List<Category>> getCategories() async {
    final db = await todosDatabase.database;
    // List<Map<String, dynamic>> result = await db.query('category',
    //     columns: ['_id', '_name', '_task_count'], orderBy: '_id');
    // return result.isNotEmpty
    //     ? result.map((item) => Category.fromMap(item)).toList()
    //     : [];

    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT _id, _name, COUNT(todos_category.category_id) AS _task_count FROM category
    LEFT JOIN todos_category ON category._id = todos_category.category_id
    GROUP BY _id''');
    return result.isNotEmpty
        ? result.map((item) => Category.fromMap(item)).toList()
        : [];
  }

  // Future updateCategory(Category category) async {
  //   final db = await todosDatabase.database;
  //   await db.transaction((txn) async {
  //     int changes1 = await txn.update('category', category.toMap(),
  //         where: '_id = ?', whereArgs: [category.id]);
  //     int changes2 = await txn.rawUpdate(
  //         'UPDATE category SET _task_count = ? WHERE _id = ?', [category.id]);
  //   });
  // }
}
