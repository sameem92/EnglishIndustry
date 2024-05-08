import 'package:json_annotation/json_annotation.dart';
part 'myweeks.g.dart';

@JsonSerializable(explicitToJson: true)
class MyWeeksModel{
 
 

  MyWeeksModel();
  // 7
  factory MyWeeksModel.fromJson(Map<String, dynamic> json) =>
      _$MyWeeksModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$MyWeeksModelToJson(this);
}
