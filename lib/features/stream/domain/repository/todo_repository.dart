import '../entities/todo_entities.dart';

abstract class TodoRepository {
  Future<Stream<TodoEntities>> getTodos();
}