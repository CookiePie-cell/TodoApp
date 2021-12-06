// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_bloc.dart';
import 'package:todo_app/bloc/todo_item_bloc/todo_item_event.dart';
import 'package:todo_app/models/category.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';

class TodoDialog extends StatefulWidget {
  TodoDialog({Key? key, this.todo}) : super(key: key);
  final Todo? todo;
  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  late String dropDownValue;
  late TextEditingController _controller;
  late TodoItemBloc todoItemBloc;

  @override
  void initState() {
    super.initState();
    todoItemBloc = context.read<TodoItemBloc>();
    dropDownValue =
        widget.todo?.category == null ? categories[1]! : widget.todo!.category;
    _controller = TextEditingController(
        text: widget.todo?.title == null ? "" : widget.todo!.title);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addSaveEvent(BuildContext context, Todo todo) {
    todoItemBloc.add(AddTodo(todo));
    Navigator.pop(context);
  }

  void _addUpdateEvent(BuildContext context, Todo todo) {
    // log('Updated: ${todo.title} + ${todo.category}');
    todoItemBloc.add(UpdateTodo(todo));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: Text('My Todo'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Todo',
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                        value: dropDownValue,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.purpleAccent[400],
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                            // log(dropDownValue);
                          });
                        },
                        items: categoryValues()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList()),
                    SizedBox(height: 10.0),
                    IconButton(
                        icon: Icon(
                          Icons.alarm,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {})
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _controller.text.isEmpty
                      ? null
                      : widget.todo?.id == null
                          ? _addSaveEvent(
                              context,
                              Todo(
                                  title: _controller.text,
                                  category: dropDownValue,
                                  dateCreated:
                                      DateTime.parse('2021-12-07 18:08:00.000'),
                                  isActive: true))
                          : _addUpdateEvent(
                              context,
                              widget.todo!.copyWith(
                                  title: _controller.text,
                                  category: dropDownValue));
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: _controller.text.isEmpty
                          ? Colors.grey
                          : Colors.purpleAccent[400],
                      fontSize: 18.0),
                ))
          ],
        );
      },
    );
  }

  List<String> categoryValues() {
    List<String> categoryValues = [];
    categories.values.forEach((element) => categoryValues.add(element));
    return categoryValues;
  }
}
