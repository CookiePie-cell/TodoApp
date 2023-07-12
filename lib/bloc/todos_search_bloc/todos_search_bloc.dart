import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/todos_search_bloc/todos_search_event.dart';
import 'package:todo_app/bloc/todos_search_bloc/todos_search_state.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:rxdart/rxdart.dart';

class TodosSearchBloc extends Bloc<TodosSearchEvent, TodosSearchState> {
  TodosSearchBloc({required this.todoRepository}) : super(TodosSearchEmpty());

  final TodoRepository todoRepository;

  @override
  Stream<TodosSearchState> mapEventToState(TodosSearchEvent event) async* {
    if (event is LoadQuery) {
      yield* _mapLoadedQueryToState(event);
    }
  }

  Stream<TodosSearchState> _mapLoadedQueryToState(LoadQuery event) async* {
    try {
      var todos = await todoRepository.getTodo(event.query);
      if (todos.isEmpty) {
        yield TodosSearchEmpty();
      } else {
        yield TodosSearchSuccess(todos);
      }
    } catch (e) {
      yield TodosSearchError();
    }
  }

  @override
  Stream<Transition<TodosSearchEvent, TodosSearchState>> transformEvents(
      Stream<TodosSearchEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 300)), transitionFn);
  }
}
