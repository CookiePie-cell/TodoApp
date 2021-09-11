// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_state.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_bloc.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_state.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_event.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/category_screen.dart';
import 'package:todo_app/ui/today_todos_screen.dart';
import 'package:todo_app/ui/todo_by_category_screen.dart';
import 'package:todo_app/ui/widgets/category_card.dart';
import 'package:todo_app/ui/widgets/section_header.dart';
import 'package:todo_app/ui/widgets/todo_dialog.dart';
import 'package:todo_app/ui/widgets/todos_list_tile.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28.0, 8.0, 28.0, 8.0),
          child: Row(
            children: [
              Text(
                "What's up, Julio!",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(28.0, 8.0, 28.0, 4.0),
          child: SectionHeader(
              title: 'Categories',
              subtitle: 'View all',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CategoryScreen()))),
        ),
        Container(
            height: 150.0,
            // padding: EdgeInsets.only(left: 28.0),
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                // log(state.toString());
                if (state is CategoryInitial) {
                  return Container();
                } else if (state is CategoryNoData) {
                  return Center(
                    child: Text("No categories available"),
                  );
                } else if (state is CategoryIsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CategoryHasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length + 1,
                    padding: EdgeInsets.only(left: 28.0),
                    itemBuilder: (context, index) {
                      if (index == 0)
                        return CategoryCard(
                          taskCount: state.totalCount,
                          category: 'All',
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => TodayTodosScreen())),
                        );
                      Category card = state.categories[index - 1];
                      return CategoryCard(
                        taskCount: card.taskCount,
                        category: card.name,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    TodoByCategoryScreen(category: card))),
                      );
                    },
                  );
                }
                return Center(
                    child: Text('Something went wrong, please try again.'));
              },
            )),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(28.0, 8.0, 28.0, 4.0),
          child: SectionHeader(
              title: "Today's tasks", subtitle: 'View all', onTap: () {}),
        ),
        Expanded(
          child: BlocBuilder<TodayTodoBloc, TodayTodoState>(
            builder: (context, state) {
              if (state is TodayTodoInitial) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text('Please wait'),
                );
              } else if (state is TodayTodoHasNoData) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text('No todos available'),
                );
              } else if (state is TodayTodoIsLoading) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text('Please wait'),
                );
              } else if (state is TodayTodoHasData) {
                return ListView.builder(
                  itemCount: state.todos.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: 28.0),
                  itemBuilder: (context, index) {
                    Todo todo = state.todos[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        context.read<TodoItemBloc>().add(DeleteTodo(todo));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${todo.title} removed')));
                      },
                      child: TodoListTile(
                          id: todo.id!,
                          title: todo.title,
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => TodoDialog(
                                    todo: todo,
                                  ))),
                    );
                  },
                );
              }
              return Align(
                alignment: Alignment.topCenter,
                child: Text('Something went wrong.'),
              );
            },
          ),
        )
      ],
    );
  }
}
