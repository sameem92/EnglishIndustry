import 'package:json_annotation/json_annotation.dart';
part 'getactivecode.g.dart';

@JsonSerializable(explicitToJson: true)
class ActiveCodeModel {
 
  @JsonKey(name: 'phone')
  String phone;  

  ActiveCodeModel({  
    this.phone,   
  });
  // 7
  factory ActiveCodeModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveCodeModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$ActiveCodeModelToJson(this);
}
