// import 'dart:developer';

import 'package:todo_app/database/TodosDatabase.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/models/todo.dart';

class TodosDao {
  final TodosDatabase todosDatabase = TodosDatabase.instance;

  Future addTodo(Todo todo) async {
    final db = await todosDatabase.database;
    await db.transaction((txn) async {
      await txn.insert('todo', todo.toMap());
      await txn.rawInsert(
          'INSERT INTO todos_category SELECT last_insert_rowid(), _id FROM category WHERE category._name = ?',
          [todo.category]);
    });
  }

  Future<List<Todo>> getTodo(String query) async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT todo._id, todo._title, category._name AS _category, DATETIME(todo._date_created) AS _date_created, todo._is_active FROM todo
        INNER JOIN todos_category ON todo._id = todos_category.todo_id
        INNER JOIN category ON todos_category.category_id = category._id
        WHERE ? != "" AND todo._title LIKE ?''', [query, '%$query%']);
    // log(result.toString());
    return result.isNotEmpty
        ? result.map((item) => Todo.fromMap(item)).toList()
        : [];
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT todo._id, todo._title, category._name AS _category, DATETIME(todo._date_created) AS _date_created, todo._is_active FROM todo
        INNER JOIN todos_category ON todo._id = todos_category.todo_id
        INNER JOIN category ON todos_category.category_id = category._id
        ORDER BY _date_created DESC''');
    return result.isNotEmpty
        ? result.map((item) => Todo.fromMap(item)).toList()
        : [];
  }

  Future<List<Todo>> getTodayTodos() async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT todo._id, todo._title, category._name AS _category, DATETIME(todo._date_created) as _date_created, todo._is_active FROM todo
        INNER JOIN todos_category ON todo._id = todos_category.todo_id
        INNER JOIN category ON todos_category.category_id = category._id
        WHERE strftime('%d', _date_created) = ?
        ORDER BY _date_created DESC''',
        [DateTime.now().day.toString().padLeft(2, '0')]);
    return result.isNotEmpty
        ? result.map((item) => Todo.fromMap(item)).toList()
        : [];
  }

  Future<List<Todo>> getTodosByCategory(int id) async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT todo._id, todo._title, category._name AS _category, DATETIME(todo._date_created) as _date_created, todo._is_active FROM todo
        INNER JOIN todos_category ON todo._id = todos_category.todo_id
        INNER JOIN category ON todos_category.category_id = category._id
        WHERE category._id = ? ORDER BY _date_created DESC''', [id]);
    return result.isNotEmpty
        ? result.map((item) => Todo.fromMap(item)).toList()
        : [];
  }

  Future updateTodo(Todo todo) async {
    final db = await todosDatabase.database;
    // log(todo.toMap().toString());
    await db.transaction((txn) async {
      await txn
          .update('todo', todo.toMap(), where: '_id = ?', whereArgs: [todo.id]);
      await txn.rawUpdate(
          'UPDATE todos_category SET category_id = (SELECT _id FROM category WHERE _name = ?) WHERE todo_id = ?',
          [todo.category, todo.id]);
    });
  }

  Future<int> deleteTodo(Todo todo) async {
    final db = await todosDatabase.database;
    return await db.delete('todo', where: '_id = ?', whereArgs: [todo.id]);
  }

  Future<List<Category>> getCategories() async {
    final db = await todosDatabase.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT _id, _name, COUNT(todos_category.category_id) AS _task_count FROM category
    LEFT JOIN todos_category ON category._id = todos_category.category_id
    GROUP BY _id''');
    return result.isNotEmpty
        ? result.map((item) => Category.fromMap(item)).toList()
        : [];
  }
}
