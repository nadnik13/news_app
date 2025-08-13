import 'package:dio/dio.dart';
import 'package:news_app/main/data/dto/news_articles_request_dto.dart';

import '../main/data/dto/news_articles_response_dto.dart';
import '../main/data/models/news_category.dart';

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
    Set<NewsCategory>? categories,
    String? q,
  }) async {
    final request = NewsArticlesRequestDto(
      category: null,
      q: q,
      country: country,
      page: page,
      pageSize: pageSize,
    );

    final Map<String, dynamic> params = {
      ...dio.options.queryParameters,
      ...request.toJson(),
    };

    final response = await dio.get(
      ApiPath.topHeadlines,
      queryParameters: params,
    );
    return NewsArticlesResponseDto.fromJson(response.data);
  }
}
