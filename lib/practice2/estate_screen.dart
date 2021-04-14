import 'package:axia_works_youtube/practice2/estate_state_notifier.dart';
import 'package:axia_works_youtube/practice2/model/estate_data.dart';
import 'package:axia_works_youtube/practice2/model/estate_item.dart';
import 'package:axia_works_youtube/practice2/model/search_data.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final estateStateProvider =
    StateNotifierProvider((ref) => EstateStateNotifier());

class EstateScreen extends ConsumerWidget {
  static const int _infoCard = 1;
  static const int _detailCard = 2;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(estateStateProvider.state);
    return Scaffold(
      appBar: _createAppBar(),
      body: Stack(
        children: [
          Container(
            child: Center(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  await context.read(estateStateProvider).fetchEstateItems();
                },
                child: state.isReadyData
                    ? _createBody(state.estateItem)
                    : Container(),
              ),
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
      floatingActionButton: _createFloatingActionButton(),
    );
  }

  Widget _createAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.teal[400]),
      title: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'おすすめ',
              style: TextStyle(color: Colors.teal[400]),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
              shape: StadiumBorder(),
            ),
          ),
          SizedBox(width: 10),
          Badge(
            badgeContent: Text('1', style: TextStyle(color: Colors.white)),
            position: BadgePosition.topEnd(top: -4, end: -4),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'リフォーム',
                style: TextStyle(color: Colors.teal[400]),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[200],
                shape: StadiumBorder(),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Icon(Icons.add_circle),
            iconSize: 40,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _createBody(List<EstateItem> estateItems) {
    return ListView.builder(
      itemCount: estateItems.length,
      itemBuilder: (context, index) {
        final data = estateItems[index];
        if (_infoCard == data.cellType) {
          return _buildSearchInfo(context, data.searchData);
        } else if (_detailCard == data.cellType) {
          return _buildEstateInfo(context, data.estateData);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey[400],
      selectedItemColor: Colors.teal[400],
      unselectedFontSize: 12,
      unselectedIconTheme: IconThemeData(size: 30),
      selectedIconTheme: IconThemeData(size: 30),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'お気に入り',
        ),
        BottomNavigationBarItem(
          icon: Badge(
            badgeContent: Text('1', style: TextStyle(color: Colors.white)),
            child: Icon(Icons.message),
          ),
          label: 'メッセージ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'マイページ',
        ),
      ],
    );
  }

  Widget _createFloatingActionButton() {
    return Container(
      width: 75,
      height: 75,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.teal[400],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search),
              Text(
                '物件',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchInfo(BuildContext context, SearchData searchData) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      height: 160,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        searchData.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '新着${searchData.num}件',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '編集',
                        style: TextStyle(color: Colors.teal[400]),
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.teal[400],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.brown[50],
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.train, size: 20),
                          SizedBox(width: 5),
                          Text(searchData.station),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.monetization_on, size: 20),
                          SizedBox(width: 5),
                          Text(searchData.price),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.info_outline, size: 20),
                          SizedBox(width: 5),
                          Text(searchData.details),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstateInfo(BuildContext context, EstateData data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.asset(data.image),
                    ),
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.asset(data.image2),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    data.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    data.price,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.train, size: 20),
                      SizedBox(width: 5),
                      Text(data.distance),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.monetization_on, size: 20),
                      SizedBox(width: 5),
                      Text(data.large),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 20),
                      SizedBox(width: 5),
                      Text(data.spec),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 170,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete, color: Colors.grey[300]),
                    label: Text('興味なし'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.grey[700],
                      side: BorderSide(color: Colors.grey[400], width: 2),
                      elevation: 0,
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, color: Colors.grey[300]),
                    label: Text('お気に入り'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.grey[700],
                      side: BorderSide(color: Colors.grey[400], width: 2),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
