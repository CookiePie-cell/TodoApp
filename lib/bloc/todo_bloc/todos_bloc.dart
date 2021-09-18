import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todos_event.dart';
import 'package:todo_app/bloc/todo_bloc/todos_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.todoRepository}) : super(AllTodosNoAction());

  final TodoRepository todoRepository;
  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllTodos) {
      yield* _mapLoadTodosToState();
    }
  }

  Stream<TodoState> _mapLoadTodosToState() async* {
    try {
      final result = await todoRepository.getAllTodos();
      if (result.isEmpty) {
        yield AllTodosNoData();
      } else {
        yield AllTodosLoaded(result);
      }
    } catch (e) {
      yield AllTodosIsError();
    }
  }
}
