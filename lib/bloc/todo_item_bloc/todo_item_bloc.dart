import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_event.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoItemBloc extends Bloc<TodoItemEvent, TodoItemState> {
  TodoItemBloc({required this.todoRepository}) : super(TodosNoAction());

  final TodoRepository todoRepository;

  @override
  Stream<TodoItemState> mapEventToState(TodoItemEvent event) async* {
    if (event is TodoItemAdded) {
      yield* _mapTodoItemAddedToState(event);
    } else if (event is TodoItemUpdated) {
      yield* _mapTodoItemUpdatedToState(event);
    } else if (event is TodoItemDeleted) {
      yield* _mapTodoItemDeleted(event);
    }
  }

  Stream<TodoItemState> _mapTodoItemAddedToState(TodoItemAdded event) async* {
    try {
      var result = await todoRepository.addTodo(event.todo);
      yield TodosUpdatedSuccess();
    } catch (e) {
      yield TodosUpdatedFailed();
    }
  }

  Stream<TodoItemState> _mapTodoItemUpdatedToState(
      TodoItemUpdated event) async* {
    try {
      var result = await todoRepository.updateTodo(event.todo);
      yield TodosUpdatedSuccess();
    } catch (e) {
      yield TodosUpdatedFailed();
    }
  }

  Stream<TodoItemState> _mapTodoItemDeleted(TodoItemDeleted event) async* {
    try {
      var result = await todoRepository.deleteTodo(event.todo);
      yield TodosUpdatedSuccess();
    } catch (e) {
      yield (TodosUpdatedFailed());
    }
  }
}
