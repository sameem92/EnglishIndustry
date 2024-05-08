import 'package:json_annotation/json_annotation.dart';
part 'faq.g.dart';

@JsonSerializable(explicitToJson: true)
class FAQModel{
 
 

  FAQModel();
  // 7
  factory FAQModel.fromJson(Map<String, dynamic> json) =>
      _$FAQModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$FAQModelToJson(this);
}
