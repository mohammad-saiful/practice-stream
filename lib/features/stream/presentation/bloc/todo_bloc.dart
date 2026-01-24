import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_stream/features/stream/domain/repository/todo_repository.dart';
import 'package:practice_stream/features/stream/presentation/bloc/todo_event.dart';
import 'package:practice_stream/features/stream/presentation/bloc/todo_state.dart';

import '../../domain/entities/todo_entities.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this._todoRepository) : super(TodoInitialState()) {
    on<GetTodosEvent>((event, emit) async {
      emit(TodoLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final response = await _todoRepository.getTodos();
        _todoListEntities = response;
        emit(TodoLoadedState(_todoListEntities, 'Todos fetched successfully'));
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        _todoListEntities.add(event.todoEntities);
        emit(TodoLoadedState(_todoListEntities, 'Todo added successfully'));
      } catch (e) {
        emit(TodoErrorState('Failed to add todo: $e'));
      }
    });

    on<UpdateTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final updatedTodos =
            _todoListEntities.map((todo) {
              if (todo.id == event.todoEntities.id) {
                return event.todoEntities;
              }
              return todo;
            }).toList();
        _todoListEntities = updatedTodos;
        emit(TodoLoadedState(_todoListEntities, 'Todo updated successfully'));
      } catch (e) {
        emit(TodoErrorState('Failed to update todo: $e'));
      }
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final updatedTodos =
            _todoListEntities
                .where((todo) => todo.id != event.todoEntities.id)
                .toList();
        _todoListEntities = updatedTodos;
        emit(TodoLoadedState(_todoListEntities, 'Todo deleted successfully'));
      } catch (e) {
        emit(TodoErrorState('Failed to delete todo: $e'));
      }
    });
  }

  final TodoRepository _todoRepository;
  List<TodoEntities> _todoListEntities = [];
}
