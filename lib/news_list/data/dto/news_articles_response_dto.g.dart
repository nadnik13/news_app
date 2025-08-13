// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_articles_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticlesResponseDto _$NewsArticlesResponseDtoFromJson(
  Map<String, dynamic> json,
) => NewsArticlesResponseDto(
  status: json['status'] as String,
  totalResults: (json['totalResults'] as num?)?.toInt(),
  articles:
      (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
  code: json['code'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$NewsArticlesResponseDtoToJson(
  NewsArticlesResponseDto instance,
) => <String, dynamic>{
  'status': instance.status,
  'totalResults': instance.totalResults,
  'articles': instance.articles,
  'code': instance.code,
  'message': instance.message,
};

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => ArticleDto(
  source:
      json['source'] == null
          ? null
          : SourceDto.fromJson(json['source'] as Map<String, dynamic>),
  title: json['title'] as String?,
  description: json['description'] as String?,
  urlToImage: json['urlToImage'] as String?,
  publishedAt: json['publishedAt'] as String?,
  content: json['content'] as String?,
);

Map<String, dynamic> _$ArticleDtoToJson(ArticleDto instance) =>
    <String, dynamic>{
      'source': instance.source,
      'title': instance.title,
      'description': instance.description,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

SourceDto _$SourceDtoFromJson(Map<String, dynamic> json) =>
    SourceDto(name: json['name'] as String);

Map<String, dynamic> _$SourceDtoToJson(SourceDto instance) => <String, dynamic>{
  'name': instance.name,
};
