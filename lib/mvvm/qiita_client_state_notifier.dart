import 'package:axia_works_youtube/mvvm/repository/qiita_repository.dart';
import 'package:axia_works_youtube/mvvm/state/qiita_client_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QiitaClientStateNotifier extends StateNotifier<QiitaClientState> {
  QiitaRepository _repository = QiitaRepository();

  QiitaClientStateNotifier() : super(QiitaClientState());

  fetchQiitaItems(String tag) async {
    state = state.copyWith(
      isLoading: true,
    );

    final qiitaItems = await _repository.fetchQiitaItems(tag);

    if (qiitaItems.length != 0) {
      state = state.copyWith(
          isLoading: false,
          isReadyData: true,
          currentTag: tag,
          qiitaItems: qiitaItems);
    } else {
      state = state.copyWith(
          isLoading: false, isReadyData: false, qiitaItems: qiitaItems);
    }
  }

  onBackHome() {
    state = state.copyWith(
      isLoading: false,
      isReadyData: false,
      currentTag: "",
    );
  }
}
