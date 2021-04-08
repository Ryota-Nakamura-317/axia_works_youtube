import 'package:axia_works_youtube/async/async_screen.dart';
import 'package:axia_works_youtube/mvvm/qiita_client_screen.dart';
import 'package:axia_works_youtube/practice1/youtube_screen.dart';
import 'package:axia_works_youtube/practice2/estate_screen.dart';
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EstateScreen(),
                  ),
                );
              },
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AsyncScreen(),
                  ),
                );
              },
              child: Text('async'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QiitaClientScreen(),
                  ),
                );
              },
              child: Text('Qiita'),
            ),
          ],
        ),
      ),
    );
  }
}
