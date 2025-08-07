// To parse this JSON data, do
//
//     final todoListModel = todoListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'todo_list_model.g.dart';

TodoListModel todoListModelFromJson(String str) => TodoListModel.fromJson(json.decode(str));

String todoListModelToJson(TodoListModel data) => json.encode(data.toJson());

@JsonSerializable()
class TodoListModel {
  @JsonKey(name: "todos")
  List<Todo>? todos;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "skip")
  int? skip;
  @JsonKey(name: "limit")
  int? limit;

  TodoListModel({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  factory TodoListModel.fromJson(Map<String, dynamic> json) => _$TodoListModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListModelToJson(this);
}

@JsonSerializable()
class Todo {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "todo")
  String? todo;
  @JsonKey(name: "completed")
  bool? completed;
  @JsonKey(name: "userId")
  int? userId;

  Todo({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
