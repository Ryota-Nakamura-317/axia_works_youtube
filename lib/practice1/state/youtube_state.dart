import 'package:axia_works_youtube/practice1/model/youtube_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_state.freezed.dart';

@freezed
abstract class YouTubeState with _$YouTubeState {
  const factory YouTubeState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    List<YouTubeItem> youtubeItem,
  }) = _YouTubeState;
}
