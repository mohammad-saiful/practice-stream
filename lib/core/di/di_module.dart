import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() => Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com/',
    ),
  );
}
