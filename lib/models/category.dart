import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final int taskCount;
  final String name;

  Category({required this.id, required this.taskCount, required this.name});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['_id'], taskCount: map['_task_count'], name: map['_name']);
  }

  Map<String, dynamic> toMap() {
    var map = {
      '_id': this.id,
      '_name': this.name,
      '_task_count': this.taskCount
    };
    return map;
  }

  @override
  List<Object?> get props => [id, taskCount, name];
}

// List<Category> categories = [
//   Category(id: 1, taskCount: 40, name: 'Business'),
//   Category(id: 2, taskCount: 10, name: 'Personal'),
//   Category(id: 3, taskCount: 2, name: 'Sport'),
// ];

Map<int, String> categories = {
  1: 'Personal',
  2: 'Bussiness',
  3: 'Study',
  4: 'Sport',
  5: 'Work'
};
