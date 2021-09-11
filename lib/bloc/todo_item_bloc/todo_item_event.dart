import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoItemEvent extends Equatable {
  const TodoItemEvent();
  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoItemEvent {
  const LoadTodos();
}

class AddTodo extends TodoItemEvent {
  final Todo todo;
  const AddTodo(this.todo);
}

class UpdateTodo extends TodoItemEvent {
  final Todo todo;
  const UpdateTodo(this.todo);
}

class DeleteTodo extends TodoItemEvent {
  final Todo todo;
  const DeleteTodo(this.todo);
}




// TODO: membuat event todo crud