import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_item.freezed.dart';
part 'youtube_item.g.dart';

@freezed
abstract class YouTubeItem with _$YouTubeItem {
  const factory YouTubeItem({
    @JsonKey(name: 'image') String image,
    @JsonKey(name: 'logo') String logo,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'subtitle') String subtitle,
  }) = _YouTubeItem;

  factory YouTubeItem.fromJson(Map<String, dynamic> json) =>
      _$YouTubeItemFromJson(json);
}
