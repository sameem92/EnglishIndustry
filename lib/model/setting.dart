import 'package:json_annotation/json_annotation.dart';
part 'setting.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingModel{
 
 

  SettingModel();
  // 7
  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}
