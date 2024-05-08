import 'package:json_annotation/json_annotation.dart';
part 'getuserhome.g.dart';

@JsonSerializable(explicitToJson: true)
class UserHomeModel{
  UserHomeModel();
  // 7
  factory UserHomeModel.fromJson(Map<String, dynamic> json) =>
      _$UserHomeModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$UserHomeModelToJson(this);
}