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
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapTodoItemAddedToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapTodoItemUpdatedToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapTodoItemDeleted(event);
    }
  }

  Stream<TodoItemState> _mapLoadTodosToState() async* {
    try {
      final result = await todoRepository.getAllTodos();
      yield TodosLoaded(result);
    } catch (e) {
      yield TodosUpdatedFailed();
    }
  }

  Stream<TodoItemState> _mapTodoItemAddedToState(AddTodo event) async* {
    try {
      await todoRepository.addTodo(event.todo);
      final result = await todoRepository.getAllTodos();
      yield TodosLoaded(result);
    } catch (e) {
      yield TodosUpdatedFailed();
    }
  }

  Stream<TodoItemState> _mapTodoItemUpdatedToState(UpdateTodo event) async* {
    try {
      await todoRepository.updateTodo(event.todo);
      final result = await todoRepository.getAllTodos();
      yield TodosLoaded(result);
    } catch (e) {
      yield TodosUpdatedFailed();
    }
  }

  Stream<TodoItemState> _mapTodoItemDeleted(DeleteTodo event) async* {
    try {
      await todoRepository.deleteTodo(event.todo);
      final result = await todoRepository.getAllTodos();
      yield TodosLoaded(result);
    } catch (e) {
      yield (TodosUpdatedFailed());
    }
  }
}
