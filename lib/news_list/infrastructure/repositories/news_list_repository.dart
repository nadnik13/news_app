import 'package:news_app/news_list/data/mappers/news_article_mapper.dart';
import 'package:news_app/news_list/data/models/news_category.dart';
import 'package:news_app/news_list/infrastructure/services/news_list_api_service.dart';
import 'package:news_app/one_news/data/models/news_article.dart';

abstract class NewsListRepository {
  Future<List<NewsArticle>> getNews({
    required int page,
    required NewsCategory? category,
    String? searchQuery,
  });
}

class NewsListRepositoryImpl implements NewsListRepository {
  final NewsListApiService api;

  NewsListRepositoryImpl({required this.api});

  @override
  Future<List<NewsArticle>> getNews({
    required int page,
    required NewsCategory? category,
    String? searchQuery,
  }) async {
    final dto = await api.fetchTopHeadlines(
      page: page,
      pageSize: 20,
      country: 'us',
      category: category,
      q: searchQuery,
    );
    return (dto.articles ?? [])
        .map((a) => a.toEntity())
        .whereType<NewsArticle>()
        .toList();
  }
}
