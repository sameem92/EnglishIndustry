import 'package:json_annotation/json_annotation.dart';
part 'deleteaccount.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteAccountModel{
 
 

  DeleteAccountModel();
  // 7
  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$DeleteAccountModelToJson(this);
}
