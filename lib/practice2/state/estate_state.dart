import 'package:axia_works_youtube/practice2/model/estate_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'estate_state.freezed.dart';

@freezed
class EstateState with _$EstateState {
  const factory EstateState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    @Default([]) List<EstateItem> estateItem,
  }) = _EstateState;
}
