import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoByCategoryState extends Equatable {
  const TodoByCategoryState();

  @override
  List<Object> get props => [];
}

class TodoByCategoryInitial extends TodoByCategoryState {
  const TodoByCategoryInitial();
}

class TodoByCategoryHasData extends TodoByCategoryState {
  final List<Todo> todos;
  const TodoByCategoryHasData(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodoByCategoryHasNoData extends TodoByCategoryState {
  const TodoByCategoryHasNoData();
}

class TodoByCategoryLoading extends TodoByCategoryState {
  const TodoByCategoryLoading();
}

class TodoByCategoryError extends TodoByCategoryState {
  const TodoByCategoryError();
}
