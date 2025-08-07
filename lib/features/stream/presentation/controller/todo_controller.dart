import 'dart:async';
import '../../domain/entities/todo_entities.dart';

enum Status { initial, loading, success, error }

class TodoController {
  TodoController();

  List<TodoEntities> todos = [];
  final StreamController<Status> loadingStream =
      StreamController<Status>.broadcast();
  final StreamController<List<TodoEntities>> todoDataStream =
      StreamController<List<TodoEntities>>.broadcast();

  void init() {
    loadingStream.add(Status.initial);
    todoDataStream.add([]);
  }

  Stream<Status> get loadingStateStream => loadingStream.stream;
  Stream<List<TodoEntities>> get stream => todoDataStream.stream;

  void add(TodoEntities todoData) async {
    loadingStream.add(Status.loading);
    todos.add(todoData);

    await Future.delayed(const Duration(seconds: 2));
    loadingStream.add(Status.success);
    await Future.delayed(const Duration(seconds: 2));
    todoDataStream.add(todos);
  }

  void delete(TodoEntities todoData) {
    todos.remove(todoData);
    todoDataStream.add(todos);
  }

  void update(TodoEntities todoData) {
    int index = todos.indexWhere((element) => element.id == todoData.id);
    todos[index] = todoData;
    todoDataStream.add(todos);
  }
}
