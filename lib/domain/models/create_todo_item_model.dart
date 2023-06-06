import 'package:json_annotation/json_annotation.dart';

part 'create_todo_item_model.g.dart';

@JsonSerializable()
class CreateTodoItemModel {
  String name;
  CreateTodoItemModel({
    required this.name,
  });

  factory CreateTodoItemModel.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTodoItemModelToJson(this);
}
