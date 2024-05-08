import 'package:json_annotation/json_annotation.dart';
part 'gethome.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeModel{
  HomeModel();
  // 7
  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}