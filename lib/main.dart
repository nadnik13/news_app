import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/screens/favorites_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/one_news_screen.dart';

import 'main/blocks/filters_blocks.dart';
import 'main/blocks/news_list_bloc.dart';
import 'main/data/repositories/news_repository.dart';
import 'main/infrastructure/news_api_service.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(name: 'home', path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
      name: 'favorites',
      path: '/favorites',
      builder: (context, state) => FavoritesScreen(),
    ),
    GoRoute(
      name: 'one_news',
      path: '/one_news/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']; // Get "id" param from URL
        return OneNewsScreen(id: id);
      },
    ),
  ],
);

void main() async {
  // final client = NewsApiService();
  // final categ = {NewsCategory.business, NewsCategory.sports};
  //
  // try {
  //   final data = await client.fetchTopHeadlines(categories: categ);
  //   print(data.articles?.first.urlToImage);
  // } on DioException catch (e) {
  //   print("Dio error: ${e.message}");
  //   if (e.response != null) {
  //     print("Status code: ${e.response?.statusCode}");
  //     print("Response data: ${e.response?.data}");
  //   }
  // } catch (e) {
  //   print("Unexpected error: $e");
  // };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NewsRepository>(
          create: (_) => NewsRepositoryImpl(api: NewsApiService()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FiltersBloc()),
          BlocProvider(
            create:
                (context) =>
                    NewsListBloc(repository: context.read<NewsRepository>()),
          ),
        ],
        child: MaterialApp.router(routerConfig: _router),
      ),
    );
  }
}
