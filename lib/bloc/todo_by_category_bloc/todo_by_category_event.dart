import 'package:equatable/equatable.dart';

class TodoByCategoryEvent extends Equatable {
  final int id;
  const TodoByCategoryEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadTodosByCategory extends TodoByCategoryEvent {
  const LoadTodosByCategory(int id) : super(id);
}

class RefreshTodosByCategory extends TodoByCategoryEvent {
  const RefreshTodosByCategory(int id) : super(id);
}
