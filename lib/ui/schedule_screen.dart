import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/bloc/todo_bloc/todos_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todos_event.dart';
import 'package:todo_app/bloc/todo_bloc/todos_state.dart';
import 'package:todo_app/models/todo.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(LoadAllTodos());
  }

  List<Todo> _getEventsForDay(DateTime day, List<Todo> todos) {
    // TODO: REFACTOR DISS STUPID DATETIME THING

    var events = {};
    todos.forEach((todo) {
      DateTime date = DateTime.utc(
          todo.dateCreated.year, todo.dateCreated.month, todo.dateCreated.day);
      if (!events.containsKey(date)) {
        events[date] = [todo];
      } else {
        events[date].add(todo);
      }
    });

    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        elevation: 1,
        title: Text(
          'Schedule',
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
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is AllTodosNoAction) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text('Loading events'),
                );
              } else if (state is AllTodosLoaded) {
                return _showCalendarWithEvent(state.todos);
              } else if (state is AllTodosNoData) {
                return _showCalendarWithoutEvent();
              } else if (state is AllTodosIsLoading) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text('Loading events'),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _showCalendarWithEvent(List<Todo> state) {
    return TableCalendar(
      firstDay: DateTime.utc(2021, 07, 15),
      lastDay: DateTime.utc(2030, 09, 15),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      eventLoader: (day) {
        return _getEventsForDay(day, state);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  Widget _showCalendarWithoutEvent() {
    return TableCalendar(
      firstDay: DateTime.utc(2021, 07, 15),
      lastDay: DateTime.utc(2030, 09, 15),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}
