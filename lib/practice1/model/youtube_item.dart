import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_item.freezed.dart';
part 'youtube_item.g.dart';

@freezed
class YouTubeItem with _$YouTubeItem {
  const factory YouTubeItem({
    @Default('') @JsonKey(name: 'image') String image,
    @Default('') @JsonKey(name: 'logo') String logo,
    @Default('') @JsonKey(name: 'title') String title,
    @Default('') @JsonKey(name: 'subtitle') String subtitle,
  }) = _YouTubeItem;

  factory YouTubeItem.fromJson(Map<String, dynamic> json) =>
      _$YouTubeItemFromJson(json);
}
