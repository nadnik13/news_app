import 'package:news_app/main/data/mappers/news_article_mapper.dart';
import 'package:news_app/main/data/models/news_category.dart';

import '../../../services/news_list_api_service.dart';
import '../../data/models/news_article.dart';

abstract class NewsListRepository {
  Future<List<NewsArticle>> getNews({
    required int page,
    required Set<NewsCategory> categories,
    String? searchQuery,
  });
}

class NewsListRepositoryImpl implements NewsListRepository {
  final NewsListApiService api;

  NewsListRepositoryImpl({required this.api});

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
