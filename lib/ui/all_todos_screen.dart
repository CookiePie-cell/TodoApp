import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todos_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todos_event.dart';
import 'package:todo_app/bloc/todo_bloc/todos_state.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_event.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_state.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/widgets/todo_dialog.dart';
import 'package:todo_app/ui/widgets/todos_list_tile.dart';

class AllTodosScreen extends StatelessWidget {
  const AllTodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoBloc>(context).add(LoadAllTodos());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'All',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocListener<TodoItemBloc, TodoItemState>(
        listener: (context, state) {
          if (state is TodosUpdatedSuccess) {
            context.read<TodoBloc>().add(LoadAllTodos());
          }
        },
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is AllTodosNoAction) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('Please wait'),
              );
            } else if (state is AllTodosNoData) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('No todos available'),
              );
            } else if (state is AllTodosIsError) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('Something went wrong'),
              );
            } else if (state is AllTodosLoaded) {
              return ListView.builder(
                  itemCount: state.todos.length,
                  scrollDirection: Axis.vertical,
                  // padding: EdgeInsets.only(left: 28),
                  itemBuilder: (context, index) {
                    Todo todo = state.todos[index];
                    log(todo.title);
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        context.read<TodoItemBloc>().add(DeleteTodo(todo));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${todo.title} removed')));
                      },
                      child: TodoListTile(
                          todo: todo,
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => TodoDialog(
                                    todo: todo,
                                  ))),
                    );
                  });
            }
            return Align(
              alignment: Alignment.topCenter,
              child: Text('Please wait'),
            );
          },
        ),
      ),
    );
  }
}
