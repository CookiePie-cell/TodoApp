import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/todo_by_category_bloc/todo_by_category_event.dart';
import 'package:todo_app/bloc/todo_by_category_bloc/todo_by_category_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoByCategoryBloc
    extends Bloc<TodoByCategoryEvent, TodoByCategoryState> {
  TodoByCategoryBloc({required this.todoRepository})
      : super(TodoByCategoryInitial());

  final TodoRepository todoRepository;

  @override
  Stream<TodoByCategoryState> mapEventToState(
      TodoByCategoryEvent event) async* {
    if (event is LoadTodosByCategory) {
      yield* mapLoadTodosByCategory(event);
    } else if (event is RefreshTodosByCategory) {
      yield* mapRefreshedTodosToState(event);
    }
  }

  Stream<TodoByCategoryState> mapLoadTodosByCategory(
      LoadTodosByCategory event) async* {
    try {
      var todos = await todoRepository.getTodosByCategory(event.id);
      if (todos.isEmpty) {
        yield TodoByCategoryHasNoData();
      } else {
        yield TodoByCategoryHasData(todos);
      }
    } catch (e) {
      yield TodoByCategoryError();
    }
  }

  Stream<TodoByCategoryState> mapRefreshedTodosToState(
      RefreshTodosByCategory event) async* {
    var todos = await todoRepository.getTodosByCategory(event.id);
    log('is this refreshed?');
    yield TodoByCategoryHasData(todos);
  }
}
