import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'news_article.g.dart';

@JsonSerializable()
class NewsArticle {
  final String id = Uuid().v4();
  final String title;
  final String subtitle;
  final String source;
  final String? imageUrl;
  final DateTime? publishedAt;
  final String text;

  NewsArticle({
    required this.title,
    required this.subtitle,
    required this.source,
    required this.imageUrl,
    required this.publishedAt,
    required this.text,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleToJson(this);
}
