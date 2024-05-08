part of 'weekdaycontent.dart';



WeekDayContentModel _$WeekDayContentModelFromJson(Map<String, dynamic> json) {
  return WeekDayContentModel(  
    weekDayId: json['weekday'] as String,
  );
}

Map<String, dynamic> _$WeekDayContentModelToJson(WeekDayContentModel instance) =>
    <String, dynamic>{      
      'weekday': instance.weekDayId,  
               
    };

