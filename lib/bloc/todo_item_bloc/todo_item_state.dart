import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

abstract class TodoItemState extends Equatable {
  const TodoItemState();
  @override
  List<Object> get props => [];
}

class TodosNoAction extends TodoItemState {
  const TodosNoAction();
}

class TodosUpdatedSuccess extends TodoItemState {
  final dynamic status;
  const TodosUpdatedSuccess(this.status);

  @override
  List<Object> get props => [status];
}

class TodosUpdatedFailed extends TodoItemState {
  const TodosUpdatedFailed();
}



// class TodoAddedLoading extends TodoItemState {
//   const TodoAddedLoading();
// }
