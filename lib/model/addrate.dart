import 'package:json_annotation/json_annotation.dart';
part 'addrate.g.dart';

@JsonSerializable(explicitToJson: true)
class AddRateModel{
 
  @JsonKey(name: 'lesson')
  String lessonId; 

  @JsonKey(name: 'rate')
  String rate; 

  AddRateModel({  
    this.lessonId,
    this.rate ,  
  });
  // 7
  factory AddRateModel.fromJson(Map<String, dynamic> json) =>
      _$AddRateModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$AddRateModelToJson(this);
}
