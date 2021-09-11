// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_by_category_bloc/todo_by_category_bloc.dart';
import 'package:todo_app/bloc/todo_by_category_bloc/todo_by_category_event.dart';
import 'package:todo_app/bloc/todo_by_category_bloc/todo_by_category_state.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_event.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/widgets/todo_dialog.dart';
import 'package:todo_app/ui/widgets/todos_list_tile.dart';
import 'package:provider/provider.dart';

class TodoByCategoryScreen extends StatelessWidget {
  const TodoByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  final Category category;

  // late TodoByCategoryBloc todoBloc;
  @override
  Widget build(BuildContext context) {
    // log('is dis getting reccaled');
    BlocProvider.of<TodoByCategoryBloc>(context)
        .add(LoadTodosByCategory(category.id));
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            category.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 32.0,
                fontWeight: FontWeight.w800),
          ),
        ),
        body: BlocBuilder<TodoByCategoryBloc, TodoByCategoryState>(
          builder: (context, state) {
            if (state is TodoByCategoryInitial) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('Please wait'),
              );
            } else if (state is TodoByCategoryHasNoData) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('No todos available'),
              );
            } else if (state is TodoByCategoryLoading) {
              return Align(
                alignment: Alignment.topCenter,
                child: Text('Please wait'),
              );
            } else if (state is TodoByCategoryHasData) {
              return ListView.builder(
                  itemCount: state.todos.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: 28),
                  itemBuilder: (context, index) {
                    Todo todo = state.todos[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        context.read<TodoItemBloc>().add(DeleteTodo(todo));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${todo.title} removed')));
                        // context.read<CategoryBloc>().add(LoadCategories());
                      },
                      child: TodoListTile(
                          id: todo.id!,
                          title: todo.title,
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => TodoDialog(
                                    todo: todo,
                                  )).then((_) => context
                              .read<TodoByCategoryBloc>()
                              .add(RefreshTodosByCategory(category.id)))),
                    );
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
