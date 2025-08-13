import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/news_list/data/models/news_category.dart';

part 'news_articles_request_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsArticlesRequestDto {
  final String country;
  final NewsCategory? category;
  final String? q;
  final int? pageSize;
  final int? page;

  NewsArticlesRequestDto({
    required this.country,
    this.category,
    this.q,
    this.page,
    this.pageSize,
  });

  factory NewsArticlesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$NewsArticlesRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticlesRequestDtoToJson(this);
}
