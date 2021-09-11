import 'package:equatable/equatable.dart';

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
