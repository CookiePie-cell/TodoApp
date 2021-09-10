import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoItemEvent extends Equatable {
  final Todo todo;
  const TodoItemEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodoItemAdded extends TodoItemEvent {
  const TodoItemAdded(Todo todo) : super(todo);
}

class TodoItemUpdated extends TodoItemEvent {
  const TodoItemUpdated(Todo todo) : super(todo);
}

class TodoItemDeleted extends TodoItemEvent {
  const TodoItemDeleted(Todo todo) : super(todo);
}



// TODO: membuat event todo crud