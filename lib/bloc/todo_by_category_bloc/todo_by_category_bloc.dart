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
      yield* mapRefreshedTodosToState(event, state);
    }
  }

  Stream<TodoByCategoryState> mapLoadTodosByCategory(
      LoadTodosByCategory event) async* {
    yield TodoByCategoryLoading();
    try {
      log('asdasd');
      var todos = await todoRepository.getTodosByCategory(event.id);
      log(todos.length.toString());
      if (todos.isEmpty) {
        yield TodoByCategoryHasNoData();
      } else {
        yield TodoByCategoryHasData(todos);
      }
    } catch (e) {
      log(e.toString());
      yield TodoByCategoryError();
    }
  }

  Stream<TodoByCategoryState> mapRefreshedTodosToState(
      RefreshTodosByCategory event, TodoByCategoryState state) async* {
    var todos = await todoRepository.getTodosByCategory(event.id);
    log(todos.length.toString());
    yield TodoByCategoryHasData(todos);
  }
}
