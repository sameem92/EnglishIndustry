import 'package:json_annotation/json_annotation.dart';
part 'logout.g.dart';

@JsonSerializable(explicitToJson: true)
class LogOutModel{
 
 
  LogOutModel();
  // 7
  factory LogOutModel.fromJson(Map<String, dynamic> json) =>
      _$LogOutModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$LogOutModelToJson(this);
}