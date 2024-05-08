import 'package:json_annotation/json_annotation.dart';
part 'finishtask.g.dart';

@JsonSerializable(explicitToJson: true)
class FinishTaskModel{
 
  @JsonKey(name: 'type')
  String type; 

  @JsonKey(name: 'weekday')
  String weekday;  

  @JsonKey(name: 'correctanswers')
  String correctAnswers;

  @JsonKey(name: 'wronganswers')
  String wrongAnswers; 

  @JsonKey(name: 'ratio')
  String ratio;  

  FinishTaskModel({  
    this.type, 
    this.weekday,   
    this.correctAnswers,   
    this.wrongAnswers,     
    this.ratio,
  });
  // 7
  factory FinishTaskModel.fromJson(Map<String, dynamic> json) =>
      _$FinishTaskModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$FinishTaskModelToJson(this);
}

