import 'package:json_annotation/json_annotation.dart';
part 'getkidshome.g.dart';

@JsonSerializable(explicitToJson: true)
class KidsHomeModel{
 
 
  KidsHomeModel();
  // 7
  factory KidsHomeModel.fromJson(Map<String, dynamic> json) =>
      _$KidsHomeModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$KidsHomeModelToJson(this);
}
