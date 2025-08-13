import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/screens/favorites_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/widgets/app_shell_scaffold.dart';
import 'package:news_app/screens/one_news_screen.dart';

import 'main/bloc/filters_bloc.dart';
import 'main/bloc/news_list_bloc.dart';
import 'main/infrastructure/news_api_service.dart';
import 'main/infrastructure/repositories/news_repository.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) => AppShellScaffold(navigationShell: navShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(name: 'home', path: '/', builder: (context, state) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(name: 'favorites', path: '/favorites', builder: (context, state) => const FavoritesScreen()),
        ]),
      ],
    ),
    GoRoute(
      name: 'one_news',
      path: '/one_news/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
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
