import 'package:mvvm_todo_list/data/repository/api_data_repository.dart';
import 'package:mvvm_todo_list/domain/repository/api_repository.dart';
import 'package:mvvm_todo_list/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ApiRepository? _apiRepository;
  static ApiRepository apiRepository() {
    return _apiRepository ??
        ApiDataRepository(
          ApiModule.api(),
        );
  }
}
