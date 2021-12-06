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
  late List<Todo> _selectedEvent;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(LoadAllTodos());
    _selectedEvent = [];
  }

  List<Todo> _getEventsForDay(DateTime day, List<Todo> todos) {
    var events = {};
    if (todos != []) {
      todos.forEach((todo) {
        DateTime date = DateTime.utc(todo.dateCreated.year,
            todo.dateCreated.month, todo.dateCreated.day);
        if (!events.containsKey(date)) {
          events[date] = [todo];
        } else {
          events[date].add(todo);
        }
      });
    }

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
                return _showCalendarWithEvent([]);
              } else if (state is AllTodosIsLoading) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text('Loading events'),
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              Todo todo = _selectedEvent[index];
              return Container(
                margin:
                    const EdgeInsets.only(right: 28.0, left: 28.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Text(
                    todo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
            itemCount: _selectedEvent.length,
          ))
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
          _selectedEvent = _getEventsForDay(_selectedDay, state);
        });
        log(_selectedEvent.toString());
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

  // Widget _showCalendarWithoutEvent() {
  //   return TableCalendar(
  //     firstDay: DateTime.utc(2021, 07, 15),
  //     lastDay: DateTime.utc(2030, 09, 15),
  //     focusedDay: _focusedDay,
  //     selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
  //     onDaySelected: (selectedDay, focusedDay) {
  //       setState(() {
  //         _selectedDay = selectedDay;
  //         _focusedDay = focusedDay;
  //       });
  //     },
  //     calendarFormat: _calendarFormat,
  //     onFormatChanged: (format) {
  //       setState(() {
  //         _calendarFormat = format;
  //       });
  //     },
  //     onPageChanged: (focusedDay) {
  //       _focusedDay = focusedDay;
  //     },
  //   );
  // }
}
