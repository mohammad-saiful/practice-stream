import 'dart:async';

import 'package:practice_stream/features/stream/domain/entities/todo_entities.dart';

class TodoControllerStream {
  TodoControllerStream() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      add(convertToTodoEntities(_count++));

      if (_count == 21) {
        timer.cancel();
      }
    });
  }

  var _count = 1;
  final _controller = StreamController<TodoEntities>.broadcast();

  Stream<TodoEntities> get stream => _controller.stream;

  void add(TodoEntities todoData) => _controller.sink.add(todoData);

  void close() => _controller.close();

  TodoEntities convertToTodoEntities(int number) {
    return TodoEntities(
      id: number,
      title: 'Todo Title $number',
      completed: number % 2 == 0,
    );
  }
}
