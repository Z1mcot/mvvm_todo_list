import 'package:dio/dio.dart';
import 'package:mvvm_todo_list/domain/models/create_todo_item_model.dart';
import 'package:mvvm_todo_list/domain/models/todo_item.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('/api/Todo/GetTodoList')
  Future<List<ToDoItem>> getTodoList(
    @Query('skip') int skip,
    @Query('take') int take,
  );

  @POST('/api/Todo/AddTodoItem')
  Future<int> addTodoItem(@Body() CreateTodoItemModel model);

  @POST('/api/Todo/UpdateItemStatus')
  Future updateItemStatus(@Query('id') int id);

  @DELETE('/api/Todo/DeleteTodoItem')
  Future deleteTodoItem(@Query('id') int id);
}
