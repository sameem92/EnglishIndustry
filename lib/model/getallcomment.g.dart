part of 'getallcomment.dart';

AllCommentsModel _$AllCommentsModelFromJson(Map<String, dynamic> json) {
  return AllCommentsModel(
    lessonId: json['lesson_id'] as String,
  );
}

Map<String, dynamic> _$AllCommentsModelToJson(AllCommentsModel instance) => <String, dynamic>{
      'lesson': instance.lessonId,
    };
