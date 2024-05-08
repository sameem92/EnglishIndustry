part of 'like.dart';

LikeModel _$LikeModelFromJson(Map<String, dynamic> json) {
  return LikeModel(
    lessonId: json['lesson'] as String,
  );
}

Map<String, dynamic> _$LikeModelToJson(LikeModel instance) => <String, dynamic>{
      'lesson': instance.lessonId,
    };
