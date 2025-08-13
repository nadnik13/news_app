import 'package:news_app/one_news/data/models/news_article.dart';

import 'package:news_app/news_list/data/dto/news_articles_response_dto.dart';

extension ArticleDtoMapper on ArticleDto {
  NewsArticle? toEntity() {
    final title = this.title;
    final description = this.description;
    final publishedAt = DateTime.tryParse(this.publishedAt ?? '')?.toLocal();
    final content = this.content;
    final sourceName = source?.name;

    if (title == null ||
        description == null ||
        publishedAt == null ||
        content == null ||
        sourceName == null) {
      return null;
    }

    return NewsArticle(
      title: title,
      subtitle: description,
      imageUrl: urlToImage,
      publishedAt: publishedAt,
      text: content,
      source: sourceName,
    );
  }
}
