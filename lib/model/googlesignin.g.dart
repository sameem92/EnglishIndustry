part of 'googlesignin.dart';

GoogleSignInModel _$GoogleSignInModelFromJson(Map<String, dynamic> json) {
  return GoogleSignInModel(
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$GoogleSignInModelToJson(GoogleSignInModel instance) => <String, dynamic>{
      'lesson': instance.email,
    };
