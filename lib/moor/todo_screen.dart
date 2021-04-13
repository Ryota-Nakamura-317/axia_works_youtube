import 'package:axia_works_youtube/moor/db.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _createBody(),
      ),
    );
  }

  Widget _createBody() {
    return Container();
  }

  Widget todoList(TodoItemData data) {
    return ListTile(
      title: Column(
        children: [
          Text(data.title),
          Text(data.sentence),
        ],
      ),
      subtitle: Row(
        children: [
          Text(data.createdAt.toString()),
          Text(data.limitDate.toString()),
        ],
      ),
    );
  }
}
