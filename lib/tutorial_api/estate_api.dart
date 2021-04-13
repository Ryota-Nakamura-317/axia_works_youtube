import 'package:axia_works_youtube/practice2/model/estate_item.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'estate_api.g.dart';

@RestApi(baseUrl: "https://hosting-json-d77c9.web.app/api/")
abstract class EstateApi {
  factory EstateApi(Dio dio, {String baseUrl}) = _EstateApi;

  static EstateApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return EstateApi(dio);
  }

  @GET("tutorial/estate.json")
  Future<List<EstateItem>> fetchEstateItems();
}
