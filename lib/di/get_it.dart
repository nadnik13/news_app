import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/main/infrastructure/repositories/favorites_list_repository.dart';
import 'package:news_app/services/news_list_api_service.dart';

import '../main/infrastructure/repositories/news_list_repository.dart';
import '../utils/api_base_options.dart';

class DI {
  static final _getIt = GetIt.instance;

  static Future<void> init() async {
    // dio
    final dio = Dio(NewsApiBaseOptions());
    // api services
    final newsApiService = NewsListApiService(dio: dio);
    // repositories
    _getIt.registerLazySingleton<NewsListRepository>(
      () => NewsListRepositoryImpl(api: newsApiService),
    );

    _getIt.registerLazySingleton<FavoritesListRepository>(
      () => FavoritesListRepositoryImpl(),
    );
  }

  static NewsListRepository get newsListRepository => _getIt.get();

  static FavoritesListRepository get favoritesListRepository => _getIt.get();
}
