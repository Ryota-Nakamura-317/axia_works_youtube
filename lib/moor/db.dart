import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

class TodoItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get sentence => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get limitDate => dateTime()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [TodoItem])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //全てのデータ取得
  Future<List<TodoItemData>> readAllTodoData() => select(todoItem).get();

  //追加
  Future writeTodo(TodoItemData data) => into(todoItem).insert(data);

  //更新
  Future updateTodo(TodoItemData data) => update(todoItem).replace(data);

  //削除
  Future deleteTodo(int id) =>
      (delete(todoItem)..where((it) => it.id.equals(id))).go();
}
