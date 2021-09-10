import 'dart:developer';

import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/services/todos_dao.dart';

class TodoDataRepository extends TodoRepository {
  final TodosDao todosDao;

  TodoDataRepository({required this.todosDao});

  @override
  Future addTodo(Todo todo) {
    return todosDao.addTodo(todo);
  }

  @override
  Future<int> deleteTodo(Todo todo) {
    return todosDao.deleteTodo(todo);
  }

  @override
  Future<List<Todo>> getAllTodos() {
    return todosDao.getAllTodos();
  }

  @override
  Future<List<Category>> getCategories() {
    return todosDao.getCategories();
  }

  @override
  Future<Todo?> getTodo(int id) {
    return todosDao.getTodo(id);
  }

  @override
  Future<List<Todo>> getTodosByCategory(int id) {
    return todosDao.getTodosByCategory(id);
  }

  @override
  Future updateTodo(Todo todo) {
    return todosDao.updateTodo(todo);
  }
}
