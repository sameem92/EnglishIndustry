import 'package:json_annotation/json_annotation.dart';
part 'words.g.dart';

@JsonSerializable(explicitToJson: true)
class WordsModel{
 
 
  WordsModel();
  // 7
  factory WordsModel.fromJson(Map<String, dynamic> json) =>
      _$WordsModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$WordsModelToJson(this);
}
