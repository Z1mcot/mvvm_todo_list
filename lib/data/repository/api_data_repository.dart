import 'package:mvvm_todo_list/data/api_clients/api_client.dart';
import 'package:mvvm_todo_list/domain/models/create_todo_item_model.dart';
import 'package:mvvm_todo_list/domain/models/todo_item.dart';
import 'package:mvvm_todo_list/domain/repository/api_repository.dart';

/// Класс-прослойка между API и клиентом.
/// Здесь стоит описать свою логику подготовки данных для отправления запросов
/// или обработки полученных данных с бэка
class ApiDataRepository extends ApiRepository {
  final ApiClient _api;
  ApiDataRepository(this._api);

  @override
  Future<int> addTodoItem(CreateTodoItemModel model) => _api.addTodoItem(model);

  @override
  Future<List<ToDoItem>> getTodoList({int skip = 0, int take = 10}) =>
      _api.getTodoList(skip, take);

  @override
  Future updateItemStatus(int id) => _api.updateItemStatus(id);

  @override
  Future deleteTodoItem(int id) => _api.deleteTodoItem(id);
}
