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
    log(todosDao.getAllTodos().toString());
    return todosDao.getAllTodos();
  }

  @override
  Future<List<Todo>> getTodayTodos() {
    return todosDao.getTodayTodos();
  }

  @override
  Future<List<Category>> getCategories() {
    return todosDao.getCategories();
  }

  @override
  Future<List<Todo>> getTodo(String query) {
    log(todosDao.getTodo(query).toString());
    return todosDao.getTodo(query);
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
