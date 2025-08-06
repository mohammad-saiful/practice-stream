import 'package:practice_stream/core/stream/todo_controller_stream.dart';
import 'package:practice_stream/features/stream/domain/repository/todo_repository.dart';

import '../domain/entities/todo_entities.dart';

class TodoRepositoryImpl extends TodoRepository {
  @override
  Future<Stream<TodoEntities>> getTodos() async
  {
    return TodoControllerStream().stream;

  }
}