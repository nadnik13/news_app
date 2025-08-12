import 'package:json_annotation/json_annotation.dart';

part 'news_articles_response_dto.g.dart';

@JsonSerializable()
class NewsArticlesResponseDto {
  final String status;
  final int? totalResults;
  final List<ArticleDto>? articles;
  final String? code;
  final String? message;

  NewsArticlesResponseDto({
    required this.status,
    this.totalResults,
    this.articles,
    this.code,
    this.message,
  });

  factory NewsArticlesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NewsArticlesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticlesResponseDtoToJson(this);
}

@JsonSerializable()
class ArticleDto {
  final SourceDto source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  ArticleDto({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDtoToJson(this);
}

@JsonSerializable()
class SourceDto {
  final String id;
  final String name;

  SourceDto({required this.id, required this.name});

  factory SourceDto.fromJson(Map<String, dynamic> json) =>
      _$SourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SourceDtoToJson(this);
}