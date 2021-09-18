import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_event.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoItemBloc extends Bloc<TodoItemEvent, TodoItemState> {
  TodoItemBloc({required this.todoRepository}) : super(TodosNoAction());

  final TodoRepository todoRepository;

  @override
  Stream<TodoItemState> mapEventToState(TodoItemEvent event) async* {
    if (event is AddTodo) {
      yield* _mapTodoItemAddedToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapTodoItemUpdatedToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapTodoItemDeleted(event);
    }
  }

  Stream<TodoItemState> _mapTodoItemAddedToState(AddTodo event) async* {
    try {
      await todoRepository.addTodo(event.todo);
      yield TodosUpdatedSuccess(DateTime.now());
    } catch (e) {
      yield TodosUpdatedFailed();
    }
  }

  Stream<TodoItemState> _mapTodoItemUpdatedToState(UpdateTodo event) async* {
    try {
      await todoRepository.updateTodo(event.todo);
      yield TodosUpdatedSuccess(DateTime.now());
    } catch (e) {
      yield TodosUpdatedFailed();
    }
  }

  Stream<TodoItemState> _mapTodoItemDeleted(DeleteTodo event) async* {
    try {
      await todoRepository.deleteTodo(event.todo);
      yield TodosUpdatedSuccess(DateTime.now());
    } catch (e) {
      yield (TodosUpdatedFailed());
    }
  }
}
