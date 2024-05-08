import 'package:json_annotation/json_annotation.dart';
part 'kidsweekdaycontent.g.dart';

@JsonSerializable(explicitToJson: true)
class KidsWeekDayContentModel{
 
  @JsonKey(name: 'weekday')
  String weekDayId;  

  KidsWeekDayContentModel({  
    this.weekDayId,   
  });
  // 7
  factory KidsWeekDayContentModel.fromJson(Map<String, dynamic> json) =>
      _$KidsWeekDayContentModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$KidsWeekDayContentModelToJson(this);
}