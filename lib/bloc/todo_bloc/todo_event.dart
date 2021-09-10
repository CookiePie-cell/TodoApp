import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadAllTodos extends TodoEvent {
  const LoadAllTodos();
}

class LoadTodosByCategory extends TodoEvent {
  final int id;
  const LoadTodosByCategory(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshTodos extends TodoEvent {
  final int id;
  const RefreshTodos(this.id);

  @override
  List<Object> get props => [id];
}

// class TodoItemAdded extends TodoEvent {
//   final Todo todo;
//   const TodoItemAdded(this.todo);
// }

// class TodoItemUpdated extends TodoEvent {
//   final Todo todo;
//   const TodoItemUpdated(this.todo);
// }

// class TodoItemDeleted extends TodoEvent {
//   final Todo todo;
//   const TodoItemDeleted(this.todo);
// }
