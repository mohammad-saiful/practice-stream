part of 'todo_cubit.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    String? message,
    List<TodoEntities>? todos,
    @Default(BaseStatus.initial()) BaseStatus status,
  }) = _TodoState;

}
