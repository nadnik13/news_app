import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/di/get_it.dart';
import 'package:news_app/favorites_list/bloc/favorites_list_bloc.dart';
import 'package:news_app/favorites_list/ui/favorites_screen.dart';
import 'package:news_app/news_list/bloc/filters_bloc.dart';
import 'package:news_app/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/news_list/ui/home_screen.dart';
import 'package:news_app/one_news/data/models/news_article.dart';
import 'package:news_app/one_news/ui/one_news_screen.dart';
import 'package:news_app/tab_bar/ui/app_shell_scaffold.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/news'),
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navShell) =>
              AppShellScaffold(navigationShell: navShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'news',
              path: '/news',
              builder:
                  (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => FiltersBloc()),
                      BlocProvider(
                        create:
                            (context) =>
                                NewsListBloc(repository: DI.newsListRepository),
                      ),
                    ],
                    child: HomeScreen(),
                  ),
              routes: [
                GoRoute(
                  name: 'one_news',
                  path: 'one_news',
                  builder: (context, state) {
                    final article = state.extra as NewsArticle;
                    return OneNewsScreen(article: article);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'favorites',
              path: '/favorites',
              builder:
                  (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => FiltersBloc()),
                      BlocProvider(
                        create:
                            (context) => FavoritesListBloc(
                              repository: DI.favoritesListRepository,
                            ),
                      ),
                    ],
                    child: const FavoritesScreen(),
                  ),
              routes: [
                GoRoute(
                  name: 'favorite_one_news',
                  path: 'one_news',
                  builder: (context, state) {
                    final article = state.extra as NewsArticle;
                    return OneNewsScreen(article: article);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FiltersBloc()),
        BlocProvider(
          create:
              (context) =>
                  FavoritesListBloc(repository: DI.favoritesListRepository),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routerConfig: _router,
      ),
    );
  }
}
