// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_articles_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticlesRequestDto _$NewsArticlesRequestDtoFromJson(
  Map<String, dynamic> json,
) => NewsArticlesRequestDto(
  country: json['country'] as String,
  category: $enumDecodeNullable(_$NewsCategoryEnumMap, json['category']),
  q: json['q'] as String?,
  page: (json['page'] as num?)?.toInt(),
  pageSize: (json['pageSize'] as num?)?.toInt(),
);

Map<String, dynamic> _$NewsArticlesRequestDtoToJson(
  NewsArticlesRequestDto instance,
) => <String, dynamic>{
  'country': instance.country,
  if (_$NewsCategoryEnumMap[instance.category] case final value?)
    'category': value,
  if (instance.q case final value?) 'q': value,
  if (instance.pageSize case final value?) 'pageSize': value,
  if (instance.page case final value?) 'page': value,
};

const _$NewsCategoryEnumMap = {
  NewsCategory.business: 'business',
  NewsCategory.general: 'general',
  NewsCategory.science: 'science',
  NewsCategory.entertainment: 'entertainment',
  NewsCategory.health: 'health',
  NewsCategory.sports: 'sports',
  NewsCategory.technology: 'technology',
};
