part of 'search.dart';

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) {
  return SearchModel(
    keyword: json['keyword'] as String,
  );
}

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) => <String, dynamic>{
      'keyword': instance.keyword,
    };
