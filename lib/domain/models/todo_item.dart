import 'package:json_annotation/json_annotation.dart';

import 'package:mvvm_todo_list/domain/db_model.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class ToDoItem implements DbModel {
  @override
  final int id;
  final String name;
  final bool isDone;

  ToDoItem({
    required this.id,
    required this.name,
    this.isDone = false,
  });

  factory ToDoItem.fromJson(Map<String, dynamic> json) =>
      _$ToDoItemFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoItemToJson(this);

  factory ToDoItem.fromMap(Map<String, dynamic> map) => _$ToDoItemFromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isDone': isDone ? 1 : 0,
    };
  }

  static ToDoItem _$ToDoItemFromMap(Map<String, dynamic> map) => ToDoItem(
        id: map['id'],
        name: map['name'],
        isDone: map['isDone'] == 1,
      );

  ToDoItem copyWith({
    int? id,
    String? name,
    bool? isDone,
  }) {
    return ToDoItem(
      id: id ?? this.id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }
}
