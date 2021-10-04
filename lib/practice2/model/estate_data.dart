import 'package:freezed_annotation/freezed_annotation.dart';

part 'estate_data.freezed.dart';
part 'estate_data.g.dart';

@freezed
class EstateData with _$EstateData {
  const factory EstateData({
    @Default('') @JsonKey(name: "image") String image,
    @Default('') @JsonKey(name: "image2") String image2,
    @Default('') @JsonKey(name: "name") String name,
    @Default('') @JsonKey(name: "price") String price,
    @Default('') @JsonKey(name: "distance") String distance,
    @Default('') @JsonKey(name: "large") String large,
    @Default('') @JsonKey(name: "spec") String spec,
  }) = _EstateData;

  factory EstateData.fromJson(Map<String, dynamic> json) =>
      _$EstateDataFromJson(json);
}
