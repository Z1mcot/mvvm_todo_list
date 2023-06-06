import 'package:flutter/material.dart';
import 'package:mvvm_todo_list/domain/models/todo_item.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoItem item;
  final Function(ToDoItem) onDelete;
  final Function(ToDoItem) onToggle;
  const ToDoItemWidget({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(color: Colors.red),
        key: Key(item.name),
        onDismissed: (_) {
          onDelete(item);
        },
        child: CheckboxListTile(
          value: item.isDone,
          onChanged: (_) {
            onToggle(item);
          },
          title: Text(item.name),
        ));
  }
}
