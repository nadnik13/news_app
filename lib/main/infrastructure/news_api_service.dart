import 'package:dio/dio.dart';
import 'package:news_app/main/data/dto/news_articles_request_dto.dart';

import '../data/dto/news_articles_response_dto.dart';

class NewsApiKeyHolder {
  static const key = String.fromEnvironment('api_key');
}

class ApiPath {
  static const topHeadlines = '/v2/top-headlines';
}

class NewsHttpClient {
  late final Dio dio;

  NewsHttpClient() {
    final options = BaseOptions(
      baseUrl: 'https://newsapi.org',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 3),
      queryParameters: {'apiKey': NewsApiKeyHolder.key},
    );
    dio = Dio(options);
  }

  Future<NewsArticlesResponseDto> fetchTopHeadlines({
    Set<NewsCategories>? categories,
    String? q,
    country = 'us',
    int page = 1,
    int pageSize = 20,
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