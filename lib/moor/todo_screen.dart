import 'package:axia_works_youtube/moor/db.dart';
import 'package:axia_works_youtube/moor/todo_state_notifier.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart' as moor;

final toDoStateNotifierProvider =
    StateNotifierProvider((ref) => TodoStateNotifier());

class TodoScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(toDoStateNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Center(
                child: state.isReadyData
                    ? _createBody(state.todoItems)
                    : Container(),
              ),
            ),
            state.isLoading
                ? Container(
                    color: Color(0x88000000),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: _createFloatingActionButton(context),
    );
  }

  Widget _createBody(List<TodoItemData> itemData) {
    return ListView.builder(
      itemCount: itemData.length,
      itemBuilder: (context, index) {
        final data = itemData[index];
        return _buildTodoItem(context, data);
      },
    );
  }

  Widget _buildTodoItem(BuildContext context, TodoItemData data) {
    return Slidable(
      actions: [
        IconSlideAction(
          caption: 'delete',
          icon: Icons.delete,
          color: Colors.red,
          onTap: () {
            context.read(toDoStateNotifierProvider.notifier).deleteData(data);
          },
        )
      ],
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'タイトル：${data.title}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                data.sentence,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('作成日：${data.createdAt.toString()}'),
                  Text(
                    '期日：${data.limitDate}',
                    style: TextStyle(color: Colors.red[400]),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      onPressed: () {
        _showInputDialog(context);
      },
    );
  }

  Future _showInputDialog(BuildContext context) {
    final today = DateTime.now();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _sentenceController = TextEditingController();
    TextEditingController _limitDateController = TextEditingController();

    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'タイトルを入力してください',
                    icon: Icon(Icons.text_fields),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null) {
                      return '未入力です';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sentenceController,
                  decoration: InputDecoration(
                    hintText: '内容を入力してください',
                    icon: Icon(Icons.text_snippet),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null) {
                      return '未入力です';
                    }
                    return null;
                  },
                ),
                DateTimePicker(
                  controller: _limitDateController,
                  dateMask: 'yyyy年MM月dd日',
                  type: DateTimePickerType.date,
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2050),
                  decoration: InputDecoration(
                    hintText: '期限を選択してください',
                    icon: Icon(Icons.calendar_today),
                  ),
                  validator: (dateTime) {
                    if (dateTime == null) {
                      return '日付が未入力です。';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () async {
                final formatter = DateFormat('yyyy-MM-dd');

                final todoData = TodoItemCompanion(
                  title: moor.Value(_titleController.text),
                  sentence: moor.Value(_sentenceController.text),
                  createdAt: moor.Value(formatter.format(today)),
                  limitDate: moor.Value(_limitDateController.text),
                );
                if (_formKey.currentState!.validate()) {
                  await context
                      .read(toDoStateNotifierProvider.notifier)
                      .writeData(todoData);
                  Navigator.of(context).pop();
                }
              },
              child: Text('保存'),
            ),
          ],
        );
      },
    );
  }
}
