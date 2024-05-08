part of 'subscripe.dart';

SubscribeModel _$SubscribeModelFromJson(Map<String, dynamic> json) {
  return SubscribeModel(
    subscriptionPlanId: json['subscription_plan'] as String,
  );
}

Map<String, dynamic> _$SubscribeModelToJson(SubscribeModel instance) => <String, dynamic>{
      'lesson': instance.subscriptionPlanId,
    };
