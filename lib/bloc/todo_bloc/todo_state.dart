import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {
  const TodoInitial();
}

class TodoHasData extends TodoState {
  final List<Todo> todos;
  const TodoHasData(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodoHasNoData extends TodoState {
  const TodoHasNoData();
}

class TodoIsLoading extends TodoState {
  const TodoIsLoading();
}

class TodoIsError extends TodoState {
  const TodoIsError();
}
