import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todos_search_bloc/todos_search_bloc.dart';
import 'package:todo_app/bloc/todos_search_bloc/todos_search_state.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/widgets/search_text_field.dart';
import 'package:todo_app/ui/widgets/todo_dialog.dart';
import 'package:todo_app/ui/widgets/todos_list_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Search todos',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.0, left: 28.0, right: 28),
            child: SearchTextField(),
          ),
          SizedBox(
            height: 12.0,
          ),
          Expanded(
            child: BlocBuilder<TodosSearchBloc, TodosSearchState>(
              builder: (context, state) {
                if (state is TodosSearchEmpty) {
                  return Container();
                } else if (state is TodosSearchSuccess) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(left: 28),
                    itemBuilder: (context, index) {
                      Todo todo = state.todos[index];
                      return TodoListTile(
                          todo: todo,
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => TodoDialog(
                                    todo: todo,
                                  )));
                    },
                  );
                } else if (state is TodosSearchError) {
                  return Align(alignment: Alignment(0.50, 0.10));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
