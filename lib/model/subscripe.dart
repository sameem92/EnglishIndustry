import 'package:json_annotation/json_annotation.dart';
part 'subscripe.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscribeModel{
 
  @JsonKey(name: 'subscription_plan')
  String subscriptionPlanId;  

  SubscribeModel({  
    this.subscriptionPlanId,   
  });
  // 7
  factory SubscribeModel.fromJson(Map<String, dynamic> json) =>
      _$SubscribeModelFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$SubscribeModelToJson(this);
}
