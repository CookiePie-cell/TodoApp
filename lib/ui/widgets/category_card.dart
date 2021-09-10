import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key,
      required this.taskCount,
      required this.category,
      required this.onTap})
      : super(key: key);

  final int taskCount;
  final String category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.only(bottom: 8.0),
        margin: EdgeInsets.only(right: 8.0),
        width: 230,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${taskCount.toString()} tasks',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
