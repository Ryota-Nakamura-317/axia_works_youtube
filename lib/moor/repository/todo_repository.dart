import 'package:axia_works_youtube/moor/db.dart';

class TodoRepository {
  TodoRepository() {
    _database = MyDatabase.getInstance();
  }

  MyDatabase _database;

  //全てのデータ取得
  Future<List<TodoItemData>> readAllData() async =>
      await _database.readAllTodoData();

  //追加
  Future writeTodoData(TodoItemData data) async =>
      await _database.writeTodo(data);

  //更新
  Future deleteTodoData(int id) async => await _database.deleteTodo(id);

  //削除
  Future updateTodoData(TodoItemData data) async =>
      await _database.updateTodo(data);
}
