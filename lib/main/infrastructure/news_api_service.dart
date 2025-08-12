import 'package:dio/dio.dart';
import 'package:news_app/main/data/dto/news_articles_request_dto.dart';

import '../data/dto/news_articles_response_dto.dart';
import '../data/models/news_category.dart';

class NewsApiKeyHolder {
  static const key = String.fromEnvironment('api_key');
}

class ApiPath {
  static const topHeadlines = '/v2/top-headlines';
}

class NewsApiService {
  late final Dio dio;

  NewsApiService() {
    final options = BaseOptions(
      baseUrl: 'https://newsapi.org',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 3),
      queryParameters: {'apiKey': NewsApiKeyHolder.key},
    );
    dio = Dio(options);
  }

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
    print(response);
    return NewsArticlesResponseDto.fromJson(response.data);
  }
}
