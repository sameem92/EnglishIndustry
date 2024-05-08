part of 'refreshtoken.dart';

RefreshTokenModel _$RefreshTokenModelFromJson(Map<String, dynamic> json) {
  return RefreshTokenModel(
    userId: json['user_id'] as String,
  );
}

Map<String, dynamic> _$RefreshTokenModelToJson(RefreshTokenModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
    };
