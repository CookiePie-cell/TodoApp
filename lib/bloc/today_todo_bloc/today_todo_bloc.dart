import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_event.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodayTodoBloc extends Bloc<TodayTodoEvent, TodayTodoState> {
  TodayTodoBloc({required this.todoRepository}) : super(TodayTodoInitial());

  final TodoRepository todoRepository;

  @override
  Stream<TodayTodoState> mapEventToState(TodayTodoEvent event) async* {
    if (event is LoadAllTodayTodos) {
      yield* mapLoadAllTodosToState();
    } else if (event is RefreshTodayTodos) {
      yield* _mapRefreshedTodosToState();
    }
  }

  Stream<TodayTodoState> mapLoadAllTodosToState() async* {
    yield TodayTodoIsLoading();
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

  Stream<TodayTodoState> _mapRefreshedTodosToState() async* {
    var todos = await todoRepository.getTodayTodos();
    yield TodayTodoHasData(todos);
  }
}
