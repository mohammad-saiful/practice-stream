import 'package:dio/dio.dart';
import 'package:practice_stream/core/network/rest_client.dart';
import 'package:practice_stream/features/stream/data/remapper/todo_entity_convertor.dart';
import 'package:practice_stream/features/stream/domain/repository/todo_repository.dart';

import '../domain/entities/todo_entities.dart';

class TodoRepositoryImpl extends TodoRepository {
  final RestClient _restClient = RestClient(
    Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
      ),
    ),
  );
  @override
  Future<List<TodoEntities>> getTodos() async {
    final response = await _restClient.getTodos();
    return TodoEntityConvertor.convertToTodoEntities(response);
  }
}
