import '../../../../core/stream/todo_controller_stream.dart';
import '../../domain/entities/todo_entities.dart';

class TodoController {
  static final TodoController _instance = TodoController._internal();

  factory TodoController() => _instance;

  TodoController._internal();

  late TodoControllerStream _todoStream;

  void init() {
    _todoStream = TodoControllerStream();
  }

  Stream<TodoEntities> get stream => _todoStream.stream;

  void add(TodoEntities todoData) => _todoStream.add(todoData);
}
