import 'package:axia_works_youtube/moor/db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    List<TodoItemData> todoItems,
  }) = _TodoState;
}
