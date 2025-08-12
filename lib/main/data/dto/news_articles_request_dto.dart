import 'package:json_annotation/json_annotation.dart';

part 'news_articles_request_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsArticlesRequestDto {
  final String country;
  final Set<NewsCategories>? category;
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

  Map<String, dynamic> toJson() {
    final json = _$NewsArticlesRequestDtoToJson(this)..removeWhere(
      (key, value) =>
          value == null ||
          (value is String && value.isEmpty) ||
          (value is Iterable && value.isEmpty),
    );

    if (category != null && category!.isNotEmpty) {
      json['category'] = category!
          .map((e) => _$NewsCategoriesEnumMap[e])
          .join(',');
    }

    return json;
  }
}

enum NewsCategories {
  @JsonValue('business')
  business,
  @JsonValue('entertainment')
  entertainment,
  @JsonValue('general')
  general,
  @JsonValue('health')
  health,
  @JsonValue('science')
  science,
  @JsonValue('sports')
  sports,
  @JsonValue('technology')
  technology,
}
