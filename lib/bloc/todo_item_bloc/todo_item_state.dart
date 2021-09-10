import 'package:equatable/equatable.dart';

abstract class TodoItemState extends Equatable {
  const TodoItemState();
  @override
  List<Object> get props => [];
}

class TodosNoAction extends TodoItemState {
  const TodosNoAction();
}

class TodosUpdatedSuccess extends TodoItemState {
  const TodosUpdatedSuccess();
}

class TodosUpdatedFailed extends TodoItemState {
  const TodosUpdatedFailed();
}



// class TodoAddedLoading extends TodoItemState {
//   const TodoAddedLoading();
// }
