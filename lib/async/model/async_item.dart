import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_item.freezed.dart';

@freezed
class AsyncItem with _$AsyncItem {
  const factory AsyncItem({
    @Default('') String name,
    @Default(0) int age,
    @Default('') String birthday,
  }) = _AsyncItem;
}
