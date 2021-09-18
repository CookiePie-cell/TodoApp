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
