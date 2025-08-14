import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_stream/features/stream/domain/repository/todo_repository.dart';
import 'package:practice_stream/features/stream/presentation/cubit/todo_cubit.dart';

import '../../features/stream/data/todo_repository_impl.dart';
import '../network/rest_client.dart';

final getIt = GetIt.instance;

class SetupDependencies {
  static Future<void> init() async {
    getIt.registerLazySingleton<RestClient>(() => RestClient(Dio()));

    getIt.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(getIt()),
    );

    getIt.registerFactory<TodoCubit>(() => TodoCubit(getIt()));
  }
}
