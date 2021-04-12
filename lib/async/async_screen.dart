import 'package:axia_works_youtube/async/async_state_notifier.dart';
import 'package:axia_works_youtube/async/model/async_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncStateNotifierProvider =
    StateNotifierProvider((ref) => AsyncStateNotifier());

class AsyncScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  String name;
  int age;
  String birthday;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(asyncStateNotifierProvider.state);
    return Scaffold(
      body: _createBody(state.asyncItem),
      floatingActionButton:
          _createFloatingActionButton(context, state.asyncItem),
    );
  }

  Widget _createBody(AsyncItem item) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.name != null ? '名前：${item.name}' : '名前：未設定'),
          Text(item.age != null ? '年齢：${item.age}' : '年齢：未設定'),
          Text(item.birthday != null ? '誕生日：${item.birthday}' : '誕生日：未設定'),
        ],
      ),
    );
  }

  Widget _createFloatingActionButton(BuildContext context, AsyncItem item) {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      onPressed: () {
        _buildShowDialog(context, item);
      },
    );
  }

  Future _buildShowDialog(BuildContext context, AsyncItem item) {
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
                  initialValue: item.name,
                  decoration: InputDecoration(
                    labelText: '名前',
                    hintText: '田中　太郎',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '未入力です';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: item.age != null ? item.age.toString() : '',
                  decoration: InputDecoration(
                    labelText: '年齢',
                    hintText: '数字で入力',
                  ),
                  validator: (value) {
                    if (value.isEmpty || num.tryParse(value) == null) {
                      return '未入力、もしくは数字ではありません';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    age = int.parse(value);
                  },
                ),
                TextFormField(
                  initialValue: item.birthday,
                  decoration: InputDecoration(
                    labelText: '誕生日',
                    hintText: '1994/1/1',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '未入力です';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    birthday = value;
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
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context
                      .read(asyncStateNotifierProvider)
                      .writeUserData(name, age, birthday);
                  this._formKey.currentState.save();
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
