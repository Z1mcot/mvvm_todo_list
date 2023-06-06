import 'package:flutter/material.dart';
import 'package:mvvm_todo_list/domain/models/create_todo_item_model.dart';

class AddTaskDialog extends StatelessWidget {
  final ValueChanged<CreateTodoItemModel> onFinish;
  const AddTaskDialog({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text;
    return AlertDialog(
      title: const Text("Add new Task"),
      content: TextField(
          autofocus: true,
          onChanged: (String userInput) {
            text = userInput;
          }),
      actions: <Widget>[
        TextButton(
          child: const Text("Add"),
          onPressed: () {
            if (text != null) {
              try {
                onFinish(CreateTodoItemModel(name: text!));
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Task ${text!} exist!")));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter Task name")));
            }
          },
        ),
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
