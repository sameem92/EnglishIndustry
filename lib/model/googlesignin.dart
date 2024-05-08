import 'package:json_annotation/json_annotation.dart';
part 'googlesignin.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleSignInModel{
 
  @JsonKey(name: 'email')
  String email;  

  GoogleSignInModel({  
    this.email,   
  });
  // 7
  factory GoogleSignInModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleSignInModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$GoogleSignInModelToJson(this);
}
