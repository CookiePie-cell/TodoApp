import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_event.dart';
import 'package:todo_app/bloc/category_bloc/category_state.dart';
import 'package:todo_app/models/category.dart';
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
        // int totalCount = await getCategoryTotal(categories);
        yield CategoryHasData(categories);
      }
    } catch (e) {
      yield CategoryError();
    }
  }

  // Future<int> getCategoryTotal(List<Category> categories) {
  //   int totalCount = 0;
  //   for (int i = 0; i < 10000; i++) {
  //     totalCount++;
  //   }
  //   categories.forEach((category) => totalCount += category.taskCount);
  //   return totalCount;
  // }
}
