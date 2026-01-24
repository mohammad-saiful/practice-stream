import '../../domain/entities/todo_entities.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  AddTodoEvent(this.todoEntities);

  final TodoEntities todoEntities;
}

class UpdateTodoEvent extends TodoEvent {
  UpdateTodoEvent(this.todoEntities);

  final TodoEntities todoEntities;
}

class DeleteTodoEvent extends TodoEvent {
  DeleteTodoEvent(this.todoEntities);

  final TodoEntities todoEntities;
}

class GetTodosEvent extends TodoEvent {}
