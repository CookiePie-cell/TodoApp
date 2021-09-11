import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

class TodosSearchState extends Equatable {
  const TodosSearchState();

  @override
  List<Object> get props => [];
}

class TodosSearchEmpty extends TodosSearchState {
  const TodosSearchEmpty();
}

class TodosSearchSuccess extends TodosSearchState {
  final List<Todo> todos;
  const TodosSearchSuccess(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodosSearchLoading extends TodosSearchState {
  const TodosSearchLoading();
}

class TodosSearchError extends TodosSearchState {
  const TodosSearchError();
}
