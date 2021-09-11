import 'package:equatable/equatable.dart';

class TodosSearchEvent extends Equatable {
  const TodosSearchEvent();
  @override
  List<Object> get props => [];
}

class LoadQuery extends TodosSearchEvent {
  final String query;
  const LoadQuery(this.query);

  @override
  List<Object> get props => [query];
}
