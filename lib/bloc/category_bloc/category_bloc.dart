import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_event.dart';
import 'package:todo_app/bloc/category_bloc/category_state.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_state.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/repository/todo_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.todoRepository, required this.todoItemBloc})
      : super(CategoryInitial()) {
    _streamSubscription = todoItemBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        log('hello');
        add(LoadCategories());
      }
    });
  }

  final TodoRepository todoRepository;
  final TodoItemBloc todoItemBloc;
  late StreamSubscription _streamSubscription;

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is LoadCategories) {
      yield* mapLoadCategoriesToState();
    }
  }

  Stream<CategoryState> mapLoadCategoriesToState() async* {
    try {
      var categories = await todoRepository.getCategories();
      if (categories.isEmpty) {
        yield CategoryNoData();
      } else {
        int totalCount = getCategoryTotal(categories);
        yield CategoryHasData(categories, totalCount);
      }
    } catch (e) {
      yield CategoryError();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  int getCategoryTotal(List<Category> categories) {
    int totalCount = 0;
    categories.forEach((category) => totalCount += category.taskCount);
    return totalCount;
  }
}
