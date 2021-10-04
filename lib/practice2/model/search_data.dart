import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_data.freezed.dart';
part 'search_data.g.dart';

@freezed
class SearchData with _$SearchData {
  const factory SearchData({
    @Default('') @JsonKey(name: "title") String title,
    @Default(0) @JsonKey(name: "num") int num,
    @Default('') @JsonKey(name: "station") String station,
    @Default('') @JsonKey(name: "price") String price,
    @Default('') @JsonKey(name: "details") String details,
  }) = _SearchData;

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
}
