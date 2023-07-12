import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilteredTodos extends FilterState {
  final List<Todo> todos;
  const FilteredTodos(this.todos);
}

class NoData extends FilterState {
  const NoData();
}
