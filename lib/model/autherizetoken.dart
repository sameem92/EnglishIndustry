import 'package:json_annotation/json_annotation.dart';
part 'autherizetoken.g.dart';

@JsonSerializable(explicitToJson: true)
class AutherizeTokenModel {
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'code')
  String code;

  AutherizeTokenModel({
    this.phone,
    this.code,
  });
  // 7
  factory AutherizeTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AutherizeTokenModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$AutherizeTokenModelToJson(this);
}
