import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../domain/repository/todo_repository.dart';
import '../../data/todo_repository_impl.dart';
import '../../domain/entities/todo_entities.dart';

enum Status { initial, loading, success, error }

class TodoController {
  final BehaviorSubject<Status> _loadingBehaviorStream =
      BehaviorSubject<Status>.seeded(Status.initial);
  final BehaviorSubject<List<TodoEntities>> _todoBehaviorStream =
      BehaviorSubject<List<TodoEntities>>.seeded([]);
  late TodoRepository _todoRepository;

  void init() {
    _todoRepository = TodoRepositoryImpl();
    getTodos();
  }

  void dispose() {
    _loadingBehaviorStream.close();
    _todoBehaviorStream.close();
  }

  Stream<Status> get loadingStateStream => _loadingBehaviorStream.stream;
  Stream<List<TodoEntities>> get todoDataStream => _todoBehaviorStream.stream;

  void getTodos() async {
    _loadingBehaviorStream.add(Status.loading);
    final response = await _todoRepository.getTodos();
    await Future.delayed(const Duration(seconds: 1));
    _loadingBehaviorStream.add(Status.success);
    _todoBehaviorStream.add(response);
  }

  void add(TodoEntities todoData) async {
    _loadingBehaviorStream.add(Status.loading);
    await Future.delayed(const Duration(seconds: 2));
    _loadingBehaviorStream.add(Status.success);
    _todoBehaviorStream.add([...getData, todoData]);
  }

  void delete(TodoEntities todoData) {
    _todoBehaviorStream.add(
      getData.where((data) => data.id != todoData.id).toList(),
    );
  }

  void update(TodoEntities todoData) {
    final updatedData =
        getData
            .map((element) => element.id == todoData.id ? todoData : element)
            .toList();
    _todoBehaviorStream.add(updatedData);
  }

  List<TodoEntities> get getData {
    return List.unmodifiable(_todoBehaviorStream.value);
  }
}
