import 'package:axia_works_youtube/moor/db.dart';
import 'package:axia_works_youtube/moor/state/todo_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoStateNotifier extends StateNotifier<TodoState> {
  TodoStateNotifier() : super(TodoState());

  MyDatabase database;

  writeData(TodoItemData data) async {
    state = state.copyWith(isLoading: true);
    await database.writeTodo(data);
    readData();
  }

  deleteData(TodoItemData data) async {
    state = state.copyWith(isLoading: true);
    await database.deleteTodo(data.id);
    readData();
  }

  readData() async {
    state = state.copyWith(isLoading: true);

    final todoItems = await database.readAllTodoData();

    state = state.copyWith(
      isLoading: false,
      isReadyData: true,
      data: todoItems,
    );
  }
}
