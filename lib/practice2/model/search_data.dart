import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_data.freezed.dart';
part 'search_data.g.dart';

@freezed
abstract class SearchData with _$SearchData {
  const factory SearchData({
    @JsonKey(name: "title") String title,
    @JsonKey(name: "num") int num,
    @JsonKey(name: "station") String station,
    @JsonKey(name: "price") String price,
    @JsonKey(name: "details") String details,
  }) = _SearchData;

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
}
