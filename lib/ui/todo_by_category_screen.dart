import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todo_event.dart';
import 'package:todo_app/bloc/todo_bloc/todo_state.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/widgets/todo_dialog.dart';
import 'package:todo_app/ui/widgets/todos_list_tile.dart';
import 'package:provider/provider.dart';

class TodoByCategoryScreen extends StatefulWidget {
  const TodoByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  final Category category;

  @override
  _TodoByCategoryScreenState createState() => _TodoByCategoryScreenState();
}

class _TodoByCategoryScreenState extends State<TodoByCategoryScreen> {
  late TodoBloc todoBloc;

  @override
  void initState() {
    super.initState();
    _loadTodosBloc();
  }

  _loadTodosBloc() {
    todoBloc = context.read<TodoBloc>();
    todoBloc.add(LoadTodosByCategory(widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            widget.category.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 32.0,
                fontWeight: FontWeight.w800),
          ),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoInitial) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('Please wait'),
              );
            } else if (state is TodoHasNoData) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('No todos available'),
              );
            } else if (state is TodoIsLoading) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('Please wait'),
              );
            } else if (state is TodoHasData) {
              return ListView.builder(
                  itemCount: state.todos.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: 28),
                  itemBuilder: (context, index) {
                    Todo todo = state.todos[index];
                    return TodoListTile(
                        id: todo.id!,
                        title: todo.title,
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => TodoDialog(
                                  todo: todo,
                                )).then((_) =>
                            todoBloc.add(RefreshTodos(widget.category.id))));
                  });
            }
            return Align(
              alignment: Alignment.topCenter,
              child: Text('Something went wrong.'),
            );
          },
        ));
  }
}
