import 'package:axia_works_youtube/moor/db.dart';

class MoorRepository {
  MoorRepository() {
    _database = MyDatabase.getInstance();
  }

  MyDatabase? _database;

  //全てのデータ取得
  Future<List<TodoItemData>> readAllTodoItems() async =>
      await _database!.readAllTodoData();

  //追加
  Future writeTodoData(TodoItemCompanion data) async =>
      await _database!.writeTodo(data);

  //更新
  Future deleteTodoData(int id) async => await _database!.deleteTodo(id);

  //削除
  Future updateTodoData(TodoItemData data) async =>
      await _database!.updateTodo(data);
}
