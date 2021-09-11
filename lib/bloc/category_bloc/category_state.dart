import 'package:equatable/equatable.dart';
import 'package:todo_app/models/category.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryHasData extends CategoryState {
  final List<Category> categories;
  final int totalCount;
  const CategoryHasData(this.categories, this.totalCount);

  @override
  List<Object> get props => [categories, totalCount];
}

class CategoryNoData extends CategoryState {
  const CategoryNoData();
}

class CategoryIsLoading extends CategoryState {
  const CategoryIsLoading();
}

class CategoryError extends CategoryState {
  const CategoryError();
}
