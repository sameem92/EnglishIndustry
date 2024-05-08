
part of 'finishtask.dart';

FinishTaskModel _$FinishTaskModelFromJson(Map<String, dynamic> json) {
  return FinishTaskModel(  
    type: json['type'] as String,
    correctAnswers: json['correctanswers'] as String,
    wrongAnswers: json['wronganswers'] as String,
    weekday: json['weekday'] as String,
    ratio: json['ratio'] as String,
  );
}

Map<String, dynamic> _$FinishTaskModelToJson(FinishTaskModel instance) =>
    <String, dynamic>{      
      'type': instance.type,  
      'correctanswers': instance.correctAnswers,  
      'wronganswers': instance.wrongAnswers,  
      'weekday': instance.weekday,  
      'ratio': instance.ratio,  
                 
    };