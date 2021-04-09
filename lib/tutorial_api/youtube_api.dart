import 'package:axia_works_youtube/practice1/model/youtube_item.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'youtube_api.g.dart';

@RestApi(baseUrl: "https://hosting-json-d77c9.web.app/api/")
abstract class YouTubeApi {
  factory YouTubeApi(Dio dio, {String baseUrl}) = _YouTubeApi;

  static YouTubeApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return YouTubeApi(dio);
  }

  @GET("tutorial/youtube.json")
  Future<List<YouTubeItem>> fetchYouTubeItems();
}
