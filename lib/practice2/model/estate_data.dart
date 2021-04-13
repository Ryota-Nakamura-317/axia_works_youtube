import 'package:freezed_annotation/freezed_annotation.dart';

part 'estate_data.freezed.dart';
part 'estate_data.g.dart';

@freezed
abstract class EstateData with _$EstateData {
  const factory EstateData({
    @JsonKey(name: "image") String image,
    @JsonKey(name: "image2") String image2,
    @JsonKey(name: "name") String name,
    @JsonKey(name: "price") String price,
    @JsonKey(name: "distance") String distance,
    @JsonKey(name: "large") String large,
    @JsonKey(name: "spec") String spec,
  }) = _EstateData;

  factory EstateData.fromJson(Map<String, dynamic> json) =>
      _$EstateDataFromJson(json);
}
