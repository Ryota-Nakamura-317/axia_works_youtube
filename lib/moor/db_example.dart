import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db_example.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()(); // 自動採番id
  TextColumn get title => text().withLength(min: 6, max: 32)(); // 制約をつける
  TextColumn get content => text().named('body')(); // カラムに別名をつける
  IntColumn get category =>
      integer().nullable()(); // nullableにする（デフォルトではnull不可）
}

@DataClassName("Category")
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> get allTodoEntries => select(todos).get();
}
