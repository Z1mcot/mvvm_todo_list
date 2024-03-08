# Важно
После всех проделанных ниже шагов, в терминале надо запустить комманду
`dart run build_runner build --delete-conflicting-outputs` для перегенерации автогенерируемых файлов

# Как отправить БД на webAPI
Предположим, на удалённом webAPI есть эндпоинт /api/Todo/uploadDB в который можно передать файл БД.

В файле [lib/data/api_clients/api_client.dart](https://github.com/Z1mcot/mvvm_todo_list/blob/master/lib/data/api_clients/api_client.dart):

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  /* Прочие методы */

  @POST('/api/Todo/uploadDB') // Путь от до эндпойинта без baseUrl
  Future<List<AttachMeta>> uploadDBFile(
      {@Part(name: "file") required File file}); // В параметре name должно стоять то название, которое присутствует в схеме API
}
```

В файле [lib/domain/repository/api_repository.dart](https://github.com/Z1mcot/mvvm_todo_list/blob/master/lib/domain/repository/api_repository.dart):

```dart
abstract class ApiRepository {
  /* Прочие методы */

  Future uploadDBFile(File file);
}
```

В файле [lib/data/repository/api_data_repository.dart](https://github.com/Z1mcot/mvvm_todo_list/blob/master/lib/data/repository/api_data_repository.dart):

```dart
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ApiDataRepository extends ApiRepository {
    final ApiClient _api;
    ApiDataRepository(this._api);
    
    /* прочие методы */

    Future uploadDBFile(File file) {
        var databasePath = await getDatabasesPath();
        var path = join(databasePath, "db_v1.0.2.db"); // Вместо `db_v1.0.2.db должно стоять название вашего файла БД
        _api.uploadDBFile(file: File(path))
    }
}
```

Название файла БД указано в [database.dart](https://github.com/Z1mcot/mvvm_todo_list/blob/master/lib/data/services/database.dart)