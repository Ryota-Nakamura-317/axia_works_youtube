import 'package:freezed_annotation/freezed_annotation.dart';

part 'estate_data.freezed.dart';
part 'estate_data.g.dart';

@freezed
abstract class EstateData with _$EstateData {
  const factory EstateData({
    @JsonKey(name: 'image') String image,
    @JsonKey(name: 'logo') String logo,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'subtitle') String subtitle,
    @JsonKey(name: 'subtitle') String subtitle,
    @JsonKey(name: 'subtitle') String subtitle,
    @JsonKey(name: 'subtitle') String subtitle,
  }) = _EstateData;

  factory EstateData.fromJson(Map<String, dynamic> json) =>
      _$EstateDataFromJson(json);
}
