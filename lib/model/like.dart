import 'package:json_annotation/json_annotation.dart';
part 'like.g.dart';

@JsonSerializable(explicitToJson: true)
class LikeModel{
 
  @JsonKey(name: 'lesson')
  String lessonId;  

  LikeModel({  
    this.lessonId,   
  });
  // 7
  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$LikeModelToJson(this);
}
