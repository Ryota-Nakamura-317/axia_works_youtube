import 'package:axia_works_youtube/practice1/repository/youtube_repository.dart';
import 'package:axia_works_youtube/practice1/state/youtube_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YouTubeStateNotifier extends StateNotifier<YouTubeState> {
  YouTubeStateNotifier() : super(YouTubeState()) {
    fetchYouTubeItems();
  }

  YouTubeRepository _repository = YouTubeRepository();

  fetchYouTubeItems() async {
    state = state.copyWith(
      isLoading: true,
    );

    final youtubeItems = await _repository.fetchYouTubeItems();

    if (youtubeItems.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        youtubeItem: youtubeItems,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        youtubeItem: youtubeItems,
      );
    }
  }
}
