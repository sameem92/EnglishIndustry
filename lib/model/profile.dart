import 'package:json_annotation/json_annotation.dart';
part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileModel{
 
 

  ProfileModel();
  // 7
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
