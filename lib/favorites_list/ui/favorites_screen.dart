import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/favorites_list/bloc/favorites_list_bloc.dart';
import 'package:news_app/news_list/ui/news_article_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Начальная загрузка из Shared Pref
    context.read<FavoritesListBloc>().add(const InitialFavoriteListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                sliver: BlocBuilder<FavoritesListBloc, FavoritesState>(
                  builder: (context, state) {
                    return SliverList.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        final item = state.articles[index];
                        return NewsArticleItem(
                          onTap:
                              () => context.go(
                                '/favorites/one_news',
                                extra: item,
                              ),
                          article: item,
                        );
                      },
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 96)),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Favorites')),
  //     body: const SizedBox.shrink(),
  //     bottomNavigationBar: BottomMenu(
  //       selected: BottomTab.favorites,
  //       onHomeTap: () => context.go('/'),
  //       onFavoritesTap: () {},
  //     ),
  //   );
  // }
}
