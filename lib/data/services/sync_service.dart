import 'package:mvvm_todo_list/data/services/data_service.dart';
import 'package:mvvm_todo_list/domain/models/todo_item.dart';
import 'package:mvvm_todo_list/internal/dependencies/api_module.dart';

class SyncService {
  final _api = ApiModule.api();
  final _dataService = DataService();

  Future syncTodoList({int skip = 0, int take = 100}) async {
    var todoListFromApi = await _api.getTodoList(skip, take);

    // TODO странная логика, под чем я был когда это писал?
    var todoList =
        todoListFromApi.map((e) => ToDoItem.fromJson(e.toJson())).toList();

    await _dataService.rangeUpdateEntities(todoList);
  }
}
