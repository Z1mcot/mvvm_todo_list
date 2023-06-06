import 'package:dio/dio.dart';
import 'package:mvvm_todo_list/data/api_clients/api_client.dart';
import 'package:mvvm_todo_list/internal/config/app_config.dart';

class ApiModule {
  static ApiClient? _apiClient;

  static ApiClient api() => _apiClient ?? ApiClient(Dio(), baseUrl: baseUrl);
}
