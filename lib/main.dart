import 'package:flutter/material.dart';
import 'package:mvvm_todo_list/data/services/database.dart';
import 'package:mvvm_todo_list/todo_list_widget.dart';

void main() async {
  // Чтобы у нас появился "инстанс" базы
  WidgetsFlutterBinding.ensureInitialized();

  await DB.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ToDoListWidget.create());
  }
}
