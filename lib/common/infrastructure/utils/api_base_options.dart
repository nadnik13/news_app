import 'package:dio/dio.dart';
import 'package:news_app/common/infrastructure/utils/api_key_holder.dart';

class NewsApiBaseOptions extends BaseOptions {
  NewsApiBaseOptions()
    : super(
        baseUrl: 'https://newsapi.org',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 3),
        queryParameters: {'apiKey': NewsApiKeyHolder.key},
      );
}
