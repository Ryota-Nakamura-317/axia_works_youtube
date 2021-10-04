import 'package:axia_works_youtube/mvvm/model/qiita_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qiita_client_state.freezed.dart';

@freezed
class QiitaClientState with _$QiitaClientState {
  const factory QiitaClientState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    @Default([]) List<QiitaItem> qiitaItems,
    @Default('') String currentTag,
  }) = _QiitaClientState;
}
