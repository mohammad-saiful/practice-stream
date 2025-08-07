import 'package:practice_stream/features/stream/data/models/todo_list_model.dart';

class TodoEntities {
  TodoEntities({
    required this.id,
    required this.title,
    required this.completed,
  });

  final int id;
  final String title;
  final bool completed;

  static List<TodoEntities> convertToTodoEntities(TodoListModel todoListModel) {
    return todoListModel.todos!
        .map(
          (e) => TodoEntities(
            id: e.id ?? 0,
            title: e.todo ?? '',
            completed: e.completed ?? false,
          ),
        )
        .toList() ?? [];
  }
}
