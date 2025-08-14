import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo_entities.dart';
import '../../domain/repository/todo_repository.dart';
import '../bloc/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this._todoRepository) : super(TodoInitialState());

  final TodoRepository _todoRepository;
  List<TodoEntities> _todoListEntities = [];

  void fetchTodos() async {
    emit(TodoLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _todoRepository.getTodos();
      _todoListEntities = response;
      emit(TodoLoadedState(_todoListEntities, 'Todos fetched successfully'));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  void addTodo(TodoEntities todoEntities) async {
    emit(TodoLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      _todoListEntities.add(todoEntities);
      emit(TodoLoadedState(_todoListEntities, 'Todo added successfully'));
    } catch (e) {
      emit(TodoErrorState('Failed to add todo: $e'));
    }
  }

  void updateTodo(TodoEntities todoEntities) async {
    emit(TodoLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final updatedTodos =
          _todoListEntities.map((todo) {
            if (todo.id == todoEntities.id) {
              return todoEntities;
            }
            return todo;
          }).toList();
      _todoListEntities = updatedTodos;
      emit(TodoLoadedState(_todoListEntities, 'Todo updated successfully'));
    } catch (e) {
      emit(TodoErrorState('Failed to update todo: $e'));
    }
  }

  void deleteTodo(TodoEntities todoEntities) async {
    emit(TodoLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final updatedTodos =
          _todoListEntities
              .where((todo) => todo.id != todoEntities.id)
              .toList();
      _todoListEntities = updatedTodos;
      emit(TodoLoadedState(_todoListEntities, 'Todo deleted successfully'));
    } catch (e) {
      emit(TodoErrorState('Failed to delete todo: $e'));
    }
  }
}
