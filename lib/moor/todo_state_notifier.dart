import 'package:axia_works_youtube/moor/db.dart';
import 'package:axia_works_youtube/moor/repository/moor_repository.dart';
import 'package:axia_works_youtube/moor/state/todo_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoStateNotifier extends StateNotifier<TodoState> {
  TodoStateNotifier() : super(TodoState()) {
    readData();
  }

  MoorRepository _repository = MoorRepository();

  writeData(TodoItemCompanion data) async {
    state = state.copyWith(isLoading: true);
    await _repository.writeTodoData(data);
    readData();
  }

  deleteData(TodoItemData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.deleteTodoData(data.id);
    readData();
  }

  readData() async {
    state = state.copyWith(isLoading: true);

    final todoItems = await _repository.readAllTodoItems();

    state = state.copyWith(
      isLoading: false,
      isReadyData: true,
      todoItems: todoItems,
    );
  }
}
