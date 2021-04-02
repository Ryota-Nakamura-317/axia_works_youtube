import 'package:flutter/material.dart';

class YouTubeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.asset('images/yt_logo_rgb_dark.png'),
            ),
          ],
        ),
        actions: [
          Icon(Icons.cast),
          SizedBox(width: 16),
          Icon(Icons.notifications_none),
          SizedBox(width: 16),
          Icon(Icons.search_rounded),
          SizedBox(width: 16),
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.lightGreen,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
