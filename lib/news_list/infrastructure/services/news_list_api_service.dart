import 'package:dio/dio.dart';
import 'package:news_app/news_list/data/dto/news_articles_request_dto.dart';
import 'package:news_app/news_list/data/dto/news_articles_response_dto.dart';
import 'package:news_app/news_list/data/models/news_category.dart';

class ApiPath {
  static const topHeadlines = '/v2/top-headlines';
}

class NewsListApiService {
  final Dio dio;

  const NewsListApiService({required this.dio});

  Future<NewsArticlesResponseDto> fetchTopHeadlines({
    required int page,
    required int pageSize,
    required String country,
    NewsCategory? category,
    String? q,
  }) async {
    final request = NewsArticlesRequestDto(
      category: category,
      q: q,
      country: country,
      page: page,
      pageSize: pageSize,
    );

    final response = await dio.get(
      ApiPath.topHeadlines,
      queryParameters: request.toJson(),
    );
    return NewsArticlesResponseDto.fromJson(response.data);
  }
}
