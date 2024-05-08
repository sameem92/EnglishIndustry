import 'package:json_annotation/json_annotation.dart';
part 'getkidsuserhome.g.dart';

@JsonSerializable(explicitToJson: true)
class KidsUserHomeModel{
 
 
  KidsUserHomeModel();
  // 7
  factory KidsUserHomeModel.fromJson(Map<String, dynamic> json) =>
      _$KidsUserHomeModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$KidsUserHomeModelToJson(this);
}
