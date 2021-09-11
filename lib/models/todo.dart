import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String title;
  final String category;
  final DateTime dateCreated;
  final bool isActive;

  Todo(
      {this.id,
      required this.title,
      required this.category,
      required this.dateCreated,
      required this.isActive});

  Todo copyWith({
    int? id,
    String? title,
    String? category,
    DateTime? dateCreated,
    bool? isActive,
  }) =>
      Todo(
          id: id ?? this.id,
          title: title ?? this.title,
          category: category ?? this.category,
          dateCreated: dateCreated ?? this.dateCreated,
          isActive: isActive ?? this.isActive);

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['_id'],
      title: map['_title'],
      category: map['_category'],
      dateCreated: DateTime.parse(map['_date_created']),
      isActive: map['_is_active'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      '_title': this.title,
      '_date_created': this.dateCreated.toIso8601String(),
      '_is_active': this.isActive == true ? 1 : 0
    };
    if (id != null) {
      map['_id'] = this.id!;
    }
    return map;
  }

  @override
  List<Object?> get props => [id, title, category, dateCreated, isActive];

  @override
  String toString() => '$id $title $category $dateCreated $isActive';
}

List<Todo> todos = [
  Todo(
      id: 1,
      title: 'Daily meeting with team',
      category: 'Business',
      dateCreated: DateTime.now(),
      isActive: true),
  Todo(
      id: 1,
      title: 'Swimming',
      category: 'Sport',
      dateCreated: DateTime.now(),
      isActive: true),
];
