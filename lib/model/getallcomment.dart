import 'package:json_annotation/json_annotation.dart';
part 'getallcomment.g.dart';

@JsonSerializable(explicitToJson: true)
class AllCommentsModel{
 
  @JsonKey(name: 'lesson_id')
  String lessonId;  

  AllCommentsModel({  
    this.lessonId,   
  });
  // 7
  factory AllCommentsModel.fromJson(Map<String, dynamic> json) =>
      _$AllCommentsModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$AllCommentsModelToJson(this);
}
