import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/widgets/bottom_menu.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const SizedBox.shrink(),
      bottomNavigationBar: BottomMenu(
        selected: BottomTab.favorites,
        onHomeTap: () => context.go('/'),
        onFavoritesTap: () {},
      ),
    );
  }
}
