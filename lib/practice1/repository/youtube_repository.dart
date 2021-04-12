import 'package:axia_works_youtube/practice1/model/youtube_item.dart';
import 'package:axia_works_youtube/tutorial_api/youtube_api.dart';

class YouTubeRepository {
  YouTubeApi _api = YouTubeApi.create();

  Future<List<YouTubeItem>> fetchYouTubeItems() async {
    return await _api.fetchYouTubeItems();
  }
}
