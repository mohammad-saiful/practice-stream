import 'package:dio/dio.dart';
import 'package:practice_stream/features/stream/data/models/todo_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://dummyjson.com/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("todos")
  Future<TodoListModel> getTodos();
}