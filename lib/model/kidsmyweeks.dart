import 'package:json_annotation/json_annotation.dart';
part 'kidsmyweeks.g.dart';

@JsonSerializable(explicitToJson: true)
class KidsMyWeeks{
 
 

  KidsMyWeeks();
  // 7
  factory KidsMyWeeks.fromJson(Map<String, dynamic> json) =>
      _$KidsMyWeeksFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$KidsMyWeeksToJson(this);
}
