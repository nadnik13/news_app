import 'package:news_app/main/data/mappers/news_article_mapper.dart';
import 'package:news_app/main/data/models/news_category.dart';

import '../../data/models/news_article.dart';
import '../news_api_service.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getNews({
    required int page,
    required Set<NewsCategory> categories,
    String? searchQuery,
  });
}

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService api;

  NewsRepositoryImpl({required this.api});

  @override
  Future<List<NewsArticle>> getNews({
    required int page,
    required Set<NewsCategory> categories,
    String? searchQuery,
  }) async {
    final dto = await api.fetchTopHeadlines(
      page: page,
      pageSize: 20,
      country: 'us',
      categories: categories,
      q: searchQuery,
    );
    return (dto.articles ?? [])
        .map((a) => a.toEntity())
        .whereType<NewsArticle>()
        .toList();
  }
}
