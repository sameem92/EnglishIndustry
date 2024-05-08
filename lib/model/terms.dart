import 'package:json_annotation/json_annotation.dart';
part 'terms.g.dart';

@JsonSerializable(explicitToJson: true)
class TermsModel{
 
 

  TermsModel();
  // 7
  factory TermsModel.fromJson(Map<String, dynamic> json) =>
      _$TermsModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$TermsModelToJson(this);
}
