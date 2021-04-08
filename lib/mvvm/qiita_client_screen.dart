import 'package:axia_works_youtube/mvvm/model/qiita_item.dart';
import 'package:axia_works_youtube/mvvm/qiita_client_state_notifier.dart';
import 'package:axia_works_youtube/mvvm/state/qiita_client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final qiitaClientStateNotifier =
    StateNotifierProvider((ref) => QiitaClientStateNotifier());

class QiitaClientScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(qiitaClientStateNotifier.state);
    return WillPopScope(
      onWillPop: state.isReadyData
          ? () {
              context.read(qiitaClientStateNotifier).onBackHome();
              return Future.value(false);
            }
          : null,
      child: Scaffold(
        appBar: AppBar(
          title: state.isReadyData
              ? Text(state.currentTag)
              : Text('QiitaClientSample'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              child: Center(
                child: state.isReadyData
                    ? _createListView(context, state.qiitaItems)
                    : _createSearchButtons(context, state),
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
      ),
    );
  }

  Widget _createListView(BuildContext context, List<QiitaItem> qiitaItems) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = qiitaItems[index];
        return Container(
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
          constraints: BoxConstraints(minHeight: 96, maxHeight: 96),
          child: Card(
            elevation: 8,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
      itemCount: qiitaItems.length,
    );
  }

  Widget _createSearchButtons(BuildContext context, QiitaClientState state) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context
                .read(qiitaClientStateNotifier)
                .fetchQiitaItems("Flutter"),
            child: Text('Flutter'),
          ),
          ElevatedButton(
            onPressed: () => context
                .read(qiitaClientStateNotifier)
                .fetchQiitaItems("android"),
            child: Text('android'),
          ),
          ElevatedButton(
            onPressed: () =>
                context.read(qiitaClientStateNotifier).fetchQiitaItems("ios"),
            child: Text('ios'),
          ),
        ],
      ),
    );
  }
}
