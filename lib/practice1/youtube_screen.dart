import 'package:axia_works_youtube/practice1/model/youtube_item.dart';
import 'package:axia_works_youtube/practice1/youtube_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeStateProvider =
    StateNotifierProvider((ref) => YouTubeStateNotifier());

class YouTubeScreen extends ConsumerWidget {
  //final _movieList = contentsList();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(youtubeStateProvider.state);
    return Scaffold(
      appBar: _createAppBar(),
      body: Stack(
        children: [
          Container(
            child: Center(
              child: state.isReadyData
                  ? _createBody(context, state.youtubeItem)
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
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }

  //_createBody(context, state.youtubeItem),

  Widget _createAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Image.asset('images/yt_logo_rgb_light.png'),
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
      backgroundColor: Colors.white,
    );
  }

  Widget _createBody(context, List<YouTubeItem> youtubeItems) {
    final size = MediaQuery.of(context).size;
    final halfButtonWidth = (size.width - 16) / 2;

    return ListView(
      children: [
        Column(
          children: [
            createCategoryButton(
              halfButtonWidth,
              Icons.local_fire_department_sharp,
              Icons.music_note,
              '急上昇',
              '音楽',
            ),
            createCategoryButton(
              halfButtonWidth,
              Icons.videogame_asset,
              Icons.text_snippet,
              'ゲーム',
              'ニュース',
            ),
            createCategoryButton(
              halfButtonWidth,
              Icons.lightbulb,
              Icons.wifi_tethering,
              '学び',
              'ライブ',
            ),
            createCategoryButton(
              halfButtonWidth,
              Icons.sports_baseball,
              Icons.music_note,
              'スポーツ',
              '',
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            '急上昇動画',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: youtubeItems.length,
          itemBuilder: (context, index) {
            final data = youtubeItems[index];
            return createMovieContents(
              context,
              data,
            );
          },
        ),
      ],
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey[700],
      selectedItemColor: Colors.red,
      unselectedFontSize: 10,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '検索',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library_sharp),
          label: 'チャンネル',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library_sharp),
          label: 'ライブラリ',
        ),
      ],
    );
  }

  Widget createCategoryButton(halfButtonWidth, IconData icon, IconData icon2,
      String label, String label2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
          width: halfButtonWidth,
          height: 55,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: 8),
                Text(label),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
          width: halfButtonWidth,
          height: 55,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Row(
              children: [
                Icon(icon2),
                SizedBox(width: 8),
                Text(label2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget createMovieContents(BuildContext context, YouTubeItem data) {
    return Column(
      children: [
        Image.asset(data.image),
        ListTile(
          title: Text(
            data.title,
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Text(
            data.subtitle,
            style: TextStyle(fontSize: 12),
          ),
          leading: CircleAvatar(
            radius: 22,
            child: ClipOval(
              child: Image.asset(data.logo),
            ),
          ),
          trailing: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}

// List<MovieData> contentsList() {
//   return [
//     MovieData(
//       'images/hq720_live.png',
//       'images/unnamed.jpg',
//       'lofi hip hop radio - beats to relax/study to',
//       'Lofi Girl 2.3万人が視聴中',
//     ),
//     MovieData(
//       'images/hq720_live.png',
//       'images/unnamed.jpg',
//       'lofi hip hop radio - beats to relax/study to',
//       'Lofi Girl 2.3万人が視聴中',
//     ),
//     MovieData(
//       'images/hq720_live.png',
//       'images/unnamed.jpg',
//       'lofi hip hop radio - beats to relax/study to',
//       'Lofi Girl 2.3万人が視聴中',
//     ),
//   ];
// }
//
// class MovieData {
//   final image;
//   final logo;
//   final title;
//   final subtitle;
//
//   MovieData(
//     this.image,
//     this.logo,
//     this.title,
//     this.subtitle,
//   );
// }
