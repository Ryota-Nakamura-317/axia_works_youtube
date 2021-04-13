import 'package:axia_works_youtube/practice2/model/estate_data.dart';
import 'package:axia_works_youtube/practice2/model/search_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'estate_item.freezed.dart';
part 'estate_item.g.dart';

@freezed
abstract class EstateItem with _$EstateItem {
  const factory EstateItem({
    @JsonKey(name: "cellType") int cellType,
    @JsonKey(name: "estateData") EstateData estateData,
    @JsonKey(name: "searchData") SearchData searchData,
  }) = _EstateItem;

  factory EstateItem.fromJson(Map<String, dynamic> json) =>
      _$EstateItemFromJson(json);
}
