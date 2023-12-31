import 'package:todo_app/models/category.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoRepository {
  Future addTodo(Todo todo);
  Future<List<Todo>> getTodo(String query);
  Future<List<Todo>> getAllTodos();
  Future<List<Todo>> getTodayTodos();
  Future<List<Todo>> getTodosByCategory(int id);
  Future<List<Category>> getCategories();
  Future updateTodo(Todo todo);
  Future<int> deleteTodo(Todo todo);
}
