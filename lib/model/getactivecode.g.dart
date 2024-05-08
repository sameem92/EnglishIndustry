part of 'getactivecode.dart';

ActiveCodeModel _$ActiveCodeModelFromJson(Map<String, dynamic> json) {
  return ActiveCodeModel(  
    phone: json['phone'] as String,      
  );
}

Map<String, dynamic> _$ActiveCodeModelToJson(ActiveCodeModel instance) =>
    <String, dynamic>{      
      'phone': instance.phone,             
    };
