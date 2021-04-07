import 'package:axia_works_youtube/prefs.dart';
import 'package:flutter/material.dart';

class AsyncScreen extends StatefulWidget {
  @override
  _AsyncScreenState createState() => _AsyncScreenState();
}

class _AsyncScreenState extends State<AsyncScreen> {
  String name;
  int age;
  String birthday;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    name = await Prefs.getName();
    age = await Prefs.getAge();
    birthday = await Prefs.getBirthday();
    setState(() {});
  }

  _saveUserData(String name, int age, String birthday) async {
    await Prefs.setName(name);
    await Prefs.setAge(age);
    await Prefs.setBirthday(birthday);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _createBody(),
      floatingActionButton: _createFloatingActionButton(),
    );
  }

  Widget _createBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name != null ? '名前：$name' : '名前：未設定'),
          Text(age != null ? '年齢：$age' : '年齢：未設定'),
          Text(birthday != null ? '誕生日：$birthday' : '誕生日：未設定'),
        ],
      ),
    );
  }

  Widget _createFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      onPressed: () {
        _createDialog(context);
      },
    );
  }

  Future _createDialog(BuildContext context) {
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
                  initialValue: name,
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
                  initialValue: age.toString(),
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
                  initialValue: birthday,
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
                  _saveUserData(name, age, birthday);
                  setState(() {});
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
