part of 'favourite.dart';

FavouriteModel _$FavouriteModelFromJson(Map<String, dynamic> json) {
  return FavouriteModel(
    lessonId: json['lesson'] as String,
  );
}

Map<String, dynamic> _$FavouriteModelToJson(FavouriteModel instance) => <String, dynamic>{
      'lesson': instance.lessonId,
    };
