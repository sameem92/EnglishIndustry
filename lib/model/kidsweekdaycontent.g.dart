part of 'kidsweekdaycontent.dart';



KidsWeekDayContentModel _$KidsWeekDayContentModelFromJson(Map<String, dynamic> json) {
  return KidsWeekDayContentModel(  
    weekDayId: json['weekday'] as String,
  );
}

Map<String, dynamic> _$KidsWeekDayContentModelToJson(KidsWeekDayContentModel instance) =>
    <String, dynamic>{      
      'weekday': instance.weekDayId,  
               
    };

