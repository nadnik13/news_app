import 'package:uuid/uuid.dart';

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
}
