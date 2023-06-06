import 'package:mvvm_todo_list/domain/models/create_todo_item_model.dart';
import 'package:mvvm_todo_list/domain/models/todo_item.dart';

abstract class ApiRepository {
  Future<List<ToDoItem>> getTodoList({int skip = 0, int take = 10});

  Future<int> addTodoItem(CreateTodoItemModel model);

  Future updateItemStatus(int id);

  Future deleteTodoItem(int id);
}
