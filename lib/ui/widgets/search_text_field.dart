import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/todos_search_bloc/todos_search_bloc.dart';
import 'package:todo_app/bloc/todos_search_bloc/todos_search_event.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_addQueryEvent);
  }

  void _addQueryEvent() {
    context.read<TodosSearchBloc>().add(LoadQuery(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search todos',
          hintStyle:
              TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 15.0),
          prefixIcon: Icon(Icons.search)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
