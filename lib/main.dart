import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/screens/favorites_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/one_news_screen.dart';
import 'package:news_app/services/http_client.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
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
      }
    ),
  ],
);

void main() {
  final client = NewsHttpClient();
  client.getDate({});
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}