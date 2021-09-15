import 'package:flutter/material.dart';
import 'package:todo_app/ui/schedule_screen.dart';
import 'package:todo_app/ui/search_screen.dart';
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SearchScreen()))),
          IconButton(
              icon: Icon(Icons.alarm, size: 30),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScheduleScreen())))
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
