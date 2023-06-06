import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvvm_todo_list/add_task_dialog.dart';
import 'package:mvvm_todo_list/data/services/data_service.dart';
import 'package:mvvm_todo_list/data/services/sync_service.dart';
import 'package:mvvm_todo_list/domain/models/create_todo_item_model.dart';
import 'package:mvvm_todo_list/domain/models/todo_item.dart';
import 'package:mvvm_todo_list/internal/dependencies/repository_module.dart';
import 'package:mvvm_todo_list/todo_item_widget.dart';

class _ModelState {
  final List<ToDoItem> items;
  final bool isLoading;

  _ModelState({
    this.items = const <ToDoItem>[],
    this.isLoading = false,
  });

  _ModelState copyWith({
    List<ToDoItem>? items,
    bool? isLoading,
  }) {
    return _ModelState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  final _api = RepositoryModule.apiRepository();
  final _syncService = SyncService();
  final _dataService = DataService();

  var _state = _ModelState();
  _ModelState get state => _state;
  set state(_ModelState val) {
    _state = _state.copyWith(items: val.items, isLoading: val.isLoading);
    notifyListeners();
  }

  _ViewModel() {
    _asyncInit();
  }

  _asyncInit() async {
    if (!state.isLoading) {
      state = state.copyWith(isLoading: true);

      await _syncService.syncTodoList();
      var todoItems = await _dataService.getToDoList();
      state = state.copyWith(items: todoItems, isLoading: false);
    }
  }

  addItem(CreateTodoItemModel model) async {
    await _api.addTodoItem(model);

    await _asyncInit();
  }

  deleteItem(ToDoItem item) async {
    await _api.deleteTodoItem(item.id);
    await _dataService.deleteTodoItem(item.id);

    await _asyncInit();
  }

  toggleItem(ToDoItem item) async {
    await _api.updateItemStatus(item.id);
    await _asyncInit();
  }
}

class ToDoListWidget extends StatelessWidget {
  const ToDoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();

    var isLoading = viewModel.state.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (_, int index) => ToDoItemWidget(
                item: viewModel.state.items[index],
                onDelete: viewModel.deleteItem,
                onToggle: viewModel.toggleItem,
              ),
              itemCount: viewModel.state.items.length,
            ),
      floatingActionButton: isLoading
          ? null
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AddTaskDialog(onFinish: viewModel.addItem),
                );
              },
              tooltip: 'Add task',
              child: const Icon(Icons.add),
            ),
    );
  }

  static Widget create() => ChangeNotifierProvider(
        create: (_) => _ViewModel(),
        child: const ToDoListWidget(),
      );
}
