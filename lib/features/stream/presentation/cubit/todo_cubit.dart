import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/base_status.dart';
import '../../domain/entities/todo_entities.dart';
import '../../domain/repository/todo_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'todo_cubit.freezed.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this._todoRepository) : super(const TodoState());

  final TodoRepository _todoRepository;
  List<TodoEntities> _todoListEntities = [];



void fetchTodos() async {
    emit(state.copyWith(status: BaseStatus.loading()));
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _todoRepository.getTodos();
      _todoListEntities = response;
      emit(state.copyWith(status: BaseStatus.success(), todos: _todoListEntities,message: 'Todos fetched successfully'));
    } catch (e) {
      emit(state.copyWith(status: BaseStatus.error(), message: 'Failed to fetch todos: $e'));
    }
  }

  void addTodo(TodoEntities todoEntities) async {
    emit(state.copyWith(status: BaseStatus.loading()));
    await Future.delayed(const Duration(seconds: 1));
    try {
      _todoListEntities.add(todoEntities);
      emit(state.copyWith(status: BaseStatus.success(), todos: _todoListEntities, message: 'Todo added successfully'));
    } catch (e) {
      emit(state.copyWith(status: BaseStatus.error(), message: 'Failed to add todo: $e'));
    }
  }

  void updateTodo(TodoEntities todoEntities) async {
    emit(state.copyWith(status: BaseStatus.loading()));
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
      emit(state.copyWith(status: BaseStatus.success(), todos: _todoListEntities, message: 'Todo updated successfully'));
    } catch (e) {
      emit(state.copyWith(status: BaseStatus.error(), message: 'Failed to update todo: $e'));
    }
  }

  void deleteTodo(TodoEntities todoEntities) async {
    emit(state.copyWith(status: BaseStatus.loading()));
    await Future.delayed(const Duration(seconds: 1));
    try {
      final updatedTodos =
          _todoListEntities
              .where((todo) => todo.id != todoEntities.id)
              .toList();
      _todoListEntities = updatedTodos;
      emit(state.copyWith(status: BaseStatus.success(), todos: _todoListEntities, message: 'Todo deleted successfully'));
    } catch (e) {
      emit(state.copyWith(status: BaseStatus.error(), message: 'Failed to delete todo: $e'));
    }
  }
}
