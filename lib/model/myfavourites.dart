import 'package:json_annotation/json_annotation.dart';
part 'myfavourites.g.dart';

@JsonSerializable(explicitToJson: true)
class MyFavouritesModel{
 
 

  MyFavouritesModel();
  // 7
  factory MyFavouritesModel.fromJson(Map<String, dynamic> json) =>
      _$MyFavouritesModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$MyFavouritesModelToJson(this);
}
