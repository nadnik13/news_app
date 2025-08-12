import '../dto/news_articles_response_dto.dart';

class NewsArticle {
  final String title;
  final String subtitle;
  final String source;
  final String urlToImage;
  final String publishedAt;
  final String text;

  NewsArticle({
    required this.title,
    required this.subtitle,
    required this.source,
    required this.urlToImage,
    required this.publishedAt,
    required this.text,
  });

  factory NewsArticle.fromDto(ArticleDto a) {
    return NewsArticle(
      title: a.title ,
      subtitle: a.description ,
      source: a.source.name,
      urlToImage: a.urlToImage,
      publishedAt: _formatDate(a.publishedAt),
      text: a.content,
    );
  }

  static List<NewsArticle> fromDtoList(List<ArticleDto> articles) {
    return articles.map(NewsArticle.fromDto).toList();
  }
}

String _formatDate(String iso) {
  // тут форматируешь дату под нужный локаль/вид
  return iso;
}