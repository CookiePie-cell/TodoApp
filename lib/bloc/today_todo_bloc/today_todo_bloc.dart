import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_event.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_state.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodayTodoBloc extends Bloc<TodayTodoEvent, TodayTodoState> {
  TodayTodoBloc({required this.todoRepository, required this.todoItemBloc})
      : super(TodayTodoInitial()) {
    _streamSubscription = todoItemBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        add(LoadAllTodayTodos());
      }
    });
  }

  final TodoRepository todoRepository;
  late TodoItemBloc todoItemBloc;
  late StreamSubscription _streamSubscription;

  @override
  Stream<TodayTodoState> mapEventToState(TodayTodoEvent event) async* {
    if (event is LoadAllTodayTodos) {
      yield* mapLoadAllTodosToState();
    }
  }

  Stream<TodayTodoState> mapLoadAllTodosToState() async* {
    // yield TodayTodoIsLoading();
    try {
      var todos = await todoRepository.getTodayTodos();
      if (todos.isEmpty) {
        yield TodayTodoHasNoData();
      } else {
        yield TodayTodoHasData(todos);
      }
    } catch (e) {
      yield TodayTodoIsError();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
