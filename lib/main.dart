import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_stream/features/stream/data/todo_repository_impl.dart';
import 'package:practice_stream/features/stream/presentation/controller/todo_bloc.dart';

import 'features/stream/presentation/view/stream_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => TodoBloc(TodoRepositoryImpl()),
          child: SafeArea(child: const StreamScreen())),
    );
  }
}
