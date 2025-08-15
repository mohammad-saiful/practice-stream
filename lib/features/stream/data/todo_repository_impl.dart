import 'package:injectable/injectable.dart';
import 'package:practice_stream/core/network/rest_client.dart';
import 'package:practice_stream/features/stream/data/remapper/todo_entity_convertor.dart';
import 'package:practice_stream/features/stream/domain/repository/todo_repository.dart';

import '../domain/entities/todo_entities.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl extends TodoRepository {
  TodoRepositoryImpl(this._restClient);

  final RestClient _restClient;

  @override
  Future<List<TodoEntities>> getTodos() async {
    final response = await _restClient.getTodos();
    return TodoEntityConvertor.convertToTodoEntities(response);
  }
}
