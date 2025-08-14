import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              //const SliverToBoxAdapter(child: SizedBox(height: 96)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 96,
                ),
                sliver: BlocBuilder<FavoritesListBloc, FavoritesState>(
                  builder: (context, state) {
                    if (state.status == FavoritesStatus.failure) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            state.errorMessage ??
                                AppLocalizations.of(context)!.load_error,
                          ),
                        ),
                      );
                    }

                    if (state.articles.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.nothing_found,
                          ),
                        ),
                      );
                    }
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
                          showStar: true,
                        );
                      },
                    );
                  },
                ),
              ),
              //const SliverToBoxAdapter(child: SizedBox(height: 96)),
            ],
          ),
        ),
      ),
    );
  }
}
