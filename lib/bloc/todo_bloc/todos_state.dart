import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object> get props => [];
}

class AllTodosNoAction extends TodoState {
  const AllTodosNoAction();
}

class AllTodosLoaded extends TodoState {
  final List<Todo> todos;
  const AllTodosLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class AllTodosNoData extends TodoState {
  const AllTodosNoData();
}

class AllTodosIsLoading extends TodoState {
  const AllTodosIsLoading();
}

class AllTodosIsError extends TodoState {
  const AllTodosIsError();
}
