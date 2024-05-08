part of 'addrate.dart';

AddRateModel _$AddRateModelFromJson(Map<String, dynamic> json) {
  return AddRateModel(  
    lessonId: json['lesson'] as String,
    rate: json['rate'] as String,
  );
}

Map<String, dynamic> _$AddRateModelToJson(AddRateModel instance) =>
    <String, dynamic>{      
      'lesson': instance.lessonId,  
       'rate': instance.rate,            
    };