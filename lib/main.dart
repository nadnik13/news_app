import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/main/bloc/favorites_list_bloc.dart';
import 'package:news_app/screens/favorites_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/one_news_screen.dart';
import 'package:news_app/widgets/app_shell_scaffold.dart';

import 'di/get_it.dart';
import 'main/bloc/filters_bloc.dart';
import 'main/bloc/news_list_bloc.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navShell) =>
              AppShellScaffold(navigationShell: navShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'home',
              path: '/',
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
                            (context) => FavoritesListBlock(
                              repository: DI.favoritesListRepository,
                            ),
                      ),
                    ],
                    child: const FavoritesScreen(),
                  ),
            ),
          ],
        ),
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
    DI.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
