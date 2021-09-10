import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodayTodoState extends Equatable {
  const TodayTodoState();

  @override
  List<Object> get props => [];
}

class TodayTodoInitial extends TodayTodoState {
  const TodayTodoInitial();
}

class TodayTodoHasData extends TodayTodoState {
  final List<Todo> todos;
  const TodayTodoHasData(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodayTodoHasNoData extends TodayTodoState {
  const TodayTodoHasNoData();
}

class TodayTodoIsLoading extends TodayTodoState {
  const TodayTodoIsLoading();
}

class TodayTodoIsError extends TodayTodoState {
  const TodayTodoIsError();
}
