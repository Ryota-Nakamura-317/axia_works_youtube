import 'package:axia_works_youtube/practice1/youtube_screen.dart';
import 'package:axia_works_youtube/practice3/mercari_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YouTubeScreen(),
                  ),
                );
              },
              child: Text('YouTube'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('estate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MercariScreen(),
                  ),
                );
              },
              child: Text('Mercari'),
            ),
          ],
        ),
      ),
    );
  }
}
