import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodayTodoEvent extends Equatable {
  const TodayTodoEvent();

  @override
  List<Object> get props => [];
}

class LoadAllTodayTodos extends TodayTodoEvent {
  const LoadAllTodayTodos();
}

// class RefreshTodayTodos extends TodayTodoEvent {
//   const RefreshTodayTodos();
// }
