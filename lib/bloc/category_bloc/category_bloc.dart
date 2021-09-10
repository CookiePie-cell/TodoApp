import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_event.dart';
import 'package:todo_app/bloc/category_bloc/category_state.dart';
import 'package:todo_app/repository/todo_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.todoRepository}) : super(CategoryInitial());

  final TodoRepository todoRepository;

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is LoadCategories) {
      yield* mapLoadCategoriesToState();
    }
  }

  Stream<CategoryState> mapLoadCategoriesToState() async* {
    yield CategoryIsLoading();
    try {
      var categories = await todoRepository.getCategories();
      if (categories.isEmpty) {
        yield CategoryNoData();
      } else {
        yield CategoryHasData(categories);
      }
    } catch (e) {
      yield CategoryError();
    }
  }
}
