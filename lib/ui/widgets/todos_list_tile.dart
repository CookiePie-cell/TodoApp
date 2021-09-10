import 'package:flutter/material.dart';

class TodoListTile extends StatefulWidget {
  const TodoListTile(
      {Key? key, required this.id, required this.title, required this.onTap})
      : super(key: key);

  final int id;
  final String title;
  final VoidCallback onTap;

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(right: 28.0, bottom: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              _checkBox(),
              SizedBox(
                width: 12.0,
              ),
              Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkBox() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.purpleAccent[400]!;
    }

    return Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateColor.resolveWith(getColor),
        value: _isChecked,
        onChanged: (bool? value) {
          setState(() {
            _isChecked = value!;
          });
        });
  }
}
