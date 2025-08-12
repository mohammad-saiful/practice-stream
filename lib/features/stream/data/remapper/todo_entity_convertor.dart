import '../../domain/entities/todo_entities.dart';
import '../models/todo_list_model.dart';

class TodoEntityConvertor {

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