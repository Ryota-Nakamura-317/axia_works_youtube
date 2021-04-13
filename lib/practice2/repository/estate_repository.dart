import 'package:axia_works_youtube/practice2/model/estate_item.dart';
import 'package:axia_works_youtube/tutorial_api/estate_api.dart';

class EstateRepository {
  EstateApi _api = EstateApi.create();

  Future<List<EstateItem>> fetchEstateItems() async {
    return await _api.fetchEstateItems();
  }
}
