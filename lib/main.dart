import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_event.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_bloc.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_event.dart';
import 'package:todo_app/bloc/todo_bloc/todos_bloc.dart';
import 'package:todo_app/bloc/todo_by_category_bloc/todo_by_category_bloc.dart';

import 'package:todo_app/bloc/todo_item_bloc/todo_item_bloc.dart';
import 'package:todo_app/bloc/todos_search_bloc/todos_search_bloc.dart';
import 'package:todo_app/repository/todo_data_repository.dart';
import 'package:todo_app/services/todos_dao.dart';
import 'package:todo_app/ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoItemBloc>(
            create: (context) => TodoItemBloc(
                todoRepository: TodoDataRepository(todosDao: TodosDao()))),
        BlocProvider<TodayTodoBloc>(
            create: (context) => TodayTodoBloc(
                  todoRepository: TodoDataRepository(todosDao: TodosDao()),
                )..add(LoadAllTodayTodos())),
        BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
                  todoRepository: TodoDataRepository(todosDao: TodosDao()),
                )..add(LoadCategories())),
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(
              todoRepository: TodoDataRepository(todosDao: TodosDao())),
        ),
        BlocProvider<TodoByCategoryBloc>(
            create: (context) => TodoByCategoryBloc(
                todoRepository: TodoDataRepository(todosDao: TodosDao()))),
        BlocProvider<TodosSearchBloc>(
            create: (context) => TodosSearchBloc(
                todoRepository: TodoDataRepository(todosDao: TodosDao())))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.indigo.shade50,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.purple[400],
            ),
            scaffoldBackgroundColor: Colors.indigo.shade50),
        home: HomeScreen(),
      ),
    );
  }
}
