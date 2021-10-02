import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_event.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodayTodoBloc extends Bloc<TodayTodoEvent, TodayTodoState> {
  TodayTodoBloc({required this.todoRepository}) : super(TodayTodoInitial());

  final TodoRepository todoRepository;
  // late StreamSubscription _streamSubscription;

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
        // log('tes');
        yield TodayTodoHasNoData();
      } else {
        // log('tes');
        yield TodayTodoHasData(todos);
      }
    } catch (e) {
      log(e.toString());
      yield TodayTodoIsError();
    }
  }

  // @override
  // Future<void> close() {
  //   _streamSubscription.cancel();
  //   return super.close();
  // }
}
