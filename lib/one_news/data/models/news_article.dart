import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_article.g.dart';

@JsonSerializable()
class NewsArticle extends Equatable {
  final String title;
  final String subtitle;
  final String source;
  final String? imageUrl;
  final DateTime publishedAt;
  final String text;

  const NewsArticle({
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

  @override
  List<Object?> get props => [
    title,
    subtitle,
    source,
    imageUrl,
    publishedAt,
    text,
  ];
}
