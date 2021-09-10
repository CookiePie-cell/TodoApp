import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todo_event.dart';
import 'package:todo_app/bloc/todo_bloc/todo_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.todoRepository}) : super(TodoInitial());

  final TodoRepository todoRepository;

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadAllTodos) {
      yield* mapLoadAllTodosToState();
    } else if (event is LoadTodosByCategory) {
      yield* mapLoadTodosByCategory(event);
    } else if (event is RefreshTodos) {
      yield* mapRefreshedTodosToState(event, state);
    }
    // else if (event is TodoItemAdded) {
    //   yield* _mapTodoItemAddedToState(event);
    // } else if (event is TodoItemUpdated) {
    //   yield* _mapTodoItemUpdatedToState(event);
    // } else if (event is TodoItemDeleted) {
    //   yield* _mapTodoItemDeleted(event);
    // }
  }

  Stream<TodoState> mapLoadAllTodosToState() async* {
    yield TodoIsLoading();
    try {
      var todos = await todoRepository.getAllTodos();
      if (todos.isEmpty) {
        yield TodoHasNoData();
      } else {
        yield TodoHasData(todos);
      }
    } catch (e) {
      yield TodoIsError();
    }
  }

  Stream<TodoState> mapLoadTodosByCategory(LoadTodosByCategory event) async* {
    yield TodoIsLoading();
    try {
      log('asdasd');
      var todos = await todoRepository.getTodosByCategory(event.id);
      log(todos.length.toString());
      if (todos.isEmpty) {
        yield TodoHasNoData();
      } else {
        yield TodoHasData(todos);
      }
    } catch (e) {
      log(e.toString());
      yield TodoIsError();
    }
  }

  Stream<TodoState> mapRefreshedTodosToState(
      RefreshTodos event, TodoState state) async* {
    var todos = await todoRepository.getTodosByCategory(event.id);
    log(todos.length.toString());
    yield TodoHasData(todos);
  }

  // Stream<TodoState> _mapTodoItemAddedToState(TodoItemAdded event){
  //    try {
  //     var result = todoRepository.updateTodo(event.todo);
  //     yield TodoUpdatedSuccess();
  //   } catch (e) {
  //     yield TodoUpdatedFailed();
  //   }
  // }
}
