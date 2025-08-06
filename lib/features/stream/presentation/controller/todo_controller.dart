import 'dart:async';
import '../../../../core/stream/todo_controller_stream.dart';
import '../../domain/entities/loading_state.dart';
import '../../domain/entities/todo_entities.dart';

enum LoadingState { initial, loading, success, error }

class TodoController {
  static final TodoController _instance = TodoController._internal();

  factory TodoController() => _instance;

  TodoController._internal();

  List<TodoEntities> todos = [];
  final TodoControllerStream _todoStream = TodoControllerStream();
  final StreamController<LoadingStateData> loadingStream =
      StreamController<LoadingStateData>.broadcast();
  final StreamController<List<TodoEntities>> todoDataStream =
      StreamController<List<TodoEntities>>.broadcast();

  void init() {
    loadingStream.add(LoadingStateData());
  }

  Stream<LoadingStateData> get loadingStateStream => loadingStream.stream;
  Stream<List<TodoEntities>> get stream => todoDataStream.stream;

  void add(TodoEntities todoData) {
    todos.add(todoData);
    todoDataStream.add(todos);
  }

  void startListeningToTodos() async {
    loadingStream.add(LoadingStateData(initial: false, loading: true));
    _todoStream.stream.listen((todo) {
      loadingStream.add(
        LoadingStateData(initial: false, loading: false, success: true),
      );
      todos.add(todo);
      todoDataStream.add(todos);
    });
  }
}
