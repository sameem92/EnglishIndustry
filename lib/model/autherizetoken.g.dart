part of 'autherizetoken.dart';



AutherizeTokenModel _$AutherizeTokenModelFromJson(Map<String, dynamic> json) {
  return AutherizeTokenModel(  
    phone: json['phone'] as String,     
    code: json['code'] as String,       
  );
}

Map<String, dynamic> _$AutherizeTokenModelToJson(AutherizeTokenModel instance) =>
    <String, dynamic>{      
      'phone': instance.phone,  
       'code': instance.code,            
    };
