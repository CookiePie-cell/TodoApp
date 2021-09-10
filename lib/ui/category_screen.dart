import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_bloc.dart';
import 'package:todo_app/bloc/category_bloc/category_event.dart';
import 'package:todo_app/bloc/category_bloc/category_state.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/ui/todo_by_category_screen.dart';
import 'package:todo_app/ui/widgets/category_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'Categories',
          style: TextStyle(
              color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.w800),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryInitial) {
            return Container();
          } else if (state is CategoryNoData) {
            return Align(
              alignment: Alignment.topCenter,
              child: Text('No category available'),
            );
          } else if (state is CategoryIsLoading) {
            return Align(
              alignment: Alignment.topCenter,
              child: Text('Please wait'),
            );
          } else if (state is CategoryHasData) {
            return GridView.builder(
                itemCount: state.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                padding: EdgeInsets.only(left: 8.0),
                itemBuilder: (context, index) {
                  Category category = state.categories[index];
                  return CategoryCard(
                      taskCount: category.taskCount,
                      category: category.name,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  TodoByCategoryScreen(category: category))));
                });
          }
          return Align(
            alignment: Alignment.topCenter,
            child: Text('Something went wrong.'),
          );
        },
      ),
    );
  }
}
