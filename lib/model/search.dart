import 'package:json_annotation/json_annotation.dart';
part 'search.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchModel{
 
  @JsonKey(name: 'keyword')
  String keyword;  

  SearchModel({  
    this.keyword,   
  });
  // 7
  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
