import 'package:mvvm_todo_list/data/services/database.dart';
import 'package:mvvm_todo_list/domain/db_model.dart';
import 'package:mvvm_todo_list/domain/models/todo_item.dart';

class DataService {
  Future createUpdateToDoItem(ToDoItem item) async {
    await DB.instance.createUpdate(item);
  }

  Future rangeUpdateEntities<T extends DbModel>(Iterable<T> elements) async {
    await DB.instance.createUpdateRange(elements);
  }

  Future<ToDoItem> getToDoItemById(int itemId) async {
    var res = await DB.instance.get<ToDoItem>(itemId);
    if (res != null) return res;
    throw Exception('Item not found');
  }

  Future deleteTodoItem(int id) async {
    var model = await DB.instance.get<ToDoItem>(id);
    if (model != null) {
      await DB.instance.delete(model);
    } else {
      throw Exception('Item not found');
    }
  }

  Future<List<ToDoItem>> getToDoList({
    int take = 10,
    int skip = 0,
  }) async {
    var items = await DB.instance.getAll<ToDoItem>(
      skip: skip,
      take: take,
    );

    return items.toList();
  }
}
