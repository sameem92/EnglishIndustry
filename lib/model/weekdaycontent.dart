import 'package:json_annotation/json_annotation.dart';
part 'weekdaycontent.g.dart';

@JsonSerializable(explicitToJson: true)
class WeekDayContentModel{
 
  @JsonKey(name: 'weekday')
  String weekDayId;  

  WeekDayContentModel({  
    this.weekDayId,   
  });
  // 7
  factory WeekDayContentModel.fromJson(Map<String, dynamic> json) =>
      _$WeekDayContentModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$WeekDayContentModelToJson(this);
}