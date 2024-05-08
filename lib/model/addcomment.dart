

import 'package:json_annotation/json_annotation.dart';
part 'addcomment.g.dart';

@JsonSerializable(explicitToJson: true)
class AddCommentModel{
 
  @JsonKey(name: 'lesson')
  String lessonId; 

  @JsonKey(name: 'comment')
  String comment; 

  AddCommentModel({  
    this.lessonId,
    this.comment ,  
  });
  // 7
  factory AddCommentModel.fromJson(Map<String, dynamic> json) =>
      _$AddCommentModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$AddCommentModelToJson(this);
}
