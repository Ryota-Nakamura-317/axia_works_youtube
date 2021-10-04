import 'package:axia_works_youtube/async/async_state_notifier.dart';
import 'package:axia_works_youtube/async/state/async_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncStateNotifierProvider =
    StateNotifierProvider((ref) => AsyncStateNotifier());

class AsyncScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(asyncStateNotifierProvider);
    return Scaffold(
      body: _createBody(state),
      floatingActionButton: _createFloatingActionButton(context, state),
    );
  }

  Widget _createBody(AsyncState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.isReadyData ? '名前：${state.asyncItem!.name}' : '名前：未設定'),
          Text(state.isReadyData ? '年齢：${state.asyncItem!.age}' : '年齢：未設定'),
          Text(state.isReadyData
              ? '誕生日：${state.asyncItem!.birthday}'
              : '誕生日：未設定'),
        ],
      ),
    );
  }

  Widget _createFloatingActionButton(BuildContext context, AsyncState state) {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      onPressed: () {
        _showInputFormDialog(context, state);
      },
    );
  }

  Future _showInputFormDialog(BuildContext context, AsyncState state) {
    String name = '';
    int age = 0;
    String birthday = '';
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
                  initialValue: state.asyncItem!.name,
                  decoration: InputDecoration(
                    labelText: '名前',
                    hintText: '田中　太郎',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return '未入力です';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) name = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: state.asyncItem != null
                      ? state.asyncItem!.age.toString()
                      : '',
                  decoration: InputDecoration(
                    labelText: '年齢',
                    hintText: '数字で入力',
                  ),
                  validator: (value) {
                    if (value == null || num.tryParse(value) == null) {
                      return '未入力、もしくは数字ではありません';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) age = int.parse(value);
                  },
                ),
                TextFormField(
                  initialValue: state.asyncItem!.birthday,
                  decoration: InputDecoration(
                    labelText: '誕生日',
                    hintText: '1994/1/1',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return '未入力です';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) birthday = value;
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
                if (_formKey.currentState!.validate()) {
                  this._formKey.currentState!.save();
                  await context
                      .read(asyncStateNotifierProvider.notifier)
                      .writeUserData(name, age, birthday);
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
