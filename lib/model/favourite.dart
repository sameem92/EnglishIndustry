import 'package:json_annotation/json_annotation.dart';
part 'favourite.g.dart';

@JsonSerializable(explicitToJson: true)
class FavouriteModel{
 
  @JsonKey(name: 'lesson')
  String lessonId;  

  FavouriteModel({  
    this.lessonId,   
  });
  // 7
  factory FavouriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavouriteModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$FavouriteModelToJson(this);
}
