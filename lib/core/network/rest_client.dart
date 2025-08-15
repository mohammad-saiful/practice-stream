import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:practice_stream/features/stream/data/models/todo_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class RestClient {
  @factoryMethod
  factory RestClient(Dio dio) = _RestClient;

  @GET("todos")
  Future<TodoListModel> getTodos();
}
