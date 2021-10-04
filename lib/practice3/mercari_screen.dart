import 'package:flutter/material.dart';

class MercariScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
    );
  }
}

AppBar _createAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text(
      '出品',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
  );
}
