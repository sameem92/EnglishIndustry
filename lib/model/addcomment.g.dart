part of 'addcomment.dart';

AddCommentModel _$AddCommentModelFromJson(Map<String, dynamic> json) {
  return AddCommentModel(
    lessonId: json['lesson'] as String,
    comment: json['comment'] as String,
  );
}

Map<String, dynamic> _$AddCommentModelToJson(AddCommentModel instance) =>
    <String, dynamic>{
      'lesson': instance.lessonId,
      'comment': instance.comment,
    };
