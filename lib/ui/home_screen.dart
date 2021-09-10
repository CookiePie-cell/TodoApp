import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_bloc.dart';
import 'package:todo_app/bloc/today_todo_bloc/today_todo_event.dart';

import 'home_screen_body.dart';
import 'widgets/todo_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {}),
          IconButton(icon: Icon(Icons.alarm, size: 30), onPressed: () {})
        ],
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.8)),
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30),
          onPressed: _openDrawer,
        ),
      ),
      drawer: Drawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        child: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return TodoDialog();
              }),
          hoverColor: Colors.purple,
          child: const Icon(Icons.add),
        ),
      ),
      body: HomeScreenBody(),
    );
  }
}
