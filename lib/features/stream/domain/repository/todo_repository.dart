import '../entities/todo_entities.dart';

abstract class TodoRepository {
  Future<List<TodoEntities>> getTodos();
}