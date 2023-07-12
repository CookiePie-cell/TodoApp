// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_app/bloc/filter_bloc/filter_event.dart';
// import 'package:todo_app/bloc/filter_bloc/filter_state.dart';
// import 'package:todo_app/models/todo.dart';

// class FilterBloc extends Bloc<FilterEvent, FilterState> {
//   FilterBloc(FilterState initialState) : super(initialState);

//   @override
//   Stream<FilterState> mapEventToState(FilterEvent event) async* {
//     if (event is showCompleted) {
//       yield* _mapFilteredStateToEvent(event);
//     }
//   }

//   Stream<FilterState> _mapFilteredStateToEvent(FilterEvent event) async* {
//     List<Todo> filteredTodos =
//         event.todos.where((todo) => todo.isActive).toList();
//     if (filteredTodos.isEmpty) {
//       yield FilteredHasNoData();
//     } else {
//       yield FilteredTodos(filteredTodos);
//     }
//   }
// }
