import 'package:json_annotation/json_annotation.dart';
part 'refreshtoken.g.dart';

@JsonSerializable(explicitToJson: true)
class RefreshTokenModel {
  @JsonKey(name: 'user_id')
  String userId;
  

  RefreshTokenModel({
    this.userId,
 
  });
  // 7
  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$RefreshTokenModelToJson(this);
}
