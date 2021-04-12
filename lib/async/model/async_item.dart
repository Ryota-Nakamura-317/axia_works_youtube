import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_item.freezed.dart';

@freezed
abstract class AsyncItem with _$AsyncItem {
  const factory AsyncItem({
    String name,
    int age,
    String birthday,
  }) = _AsyncItem;
}
