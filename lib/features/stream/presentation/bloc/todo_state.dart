import '../../domain/entities/todo_entities.dart';

abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  TodoLoadedState(this.todoListEntities, this.successMessage);

  final List<TodoEntities> todoListEntities;
  final String successMessage;
}

class TodoErrorState extends TodoState {
  TodoErrorState(this.message);

  final String message;
}