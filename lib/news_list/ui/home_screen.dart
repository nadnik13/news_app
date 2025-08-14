import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/common/ui/lazy_loading_listview_builder.dart';
import 'package:news_app/common/ui/news_article_item.dart';
import 'package:news_app/news_list/bloc/filters_bloc.dart';
import 'package:news_app/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/news_list/ui/filters_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Начальная загрузка без фильтров и без поиска
    context.read<NewsListBloc>().add(const InitialNewsListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: LazyLoadingListviewBuilder(
            loadMore: () => _loadMore(),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _PinnedHeaderDelegate(
                  height: 120,
                  child: const FiltersWidget(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                sliver: BlocBuilder<NewsListBloc, NewsListState>(
                  builder: (context, state) {
                    if (state.status == NewsListStatus.loading) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state.status == NewsListStatus.failure) {
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

                    if (state.items.isEmpty) {
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
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return NewsArticleItem(
                          onTap:
                              () => context.go('/news/one_news', extra: item),
                          article: item,
                          showStar: false,
                        );
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<NewsListBloc, NewsListState>(
                builder: (context, state) {
                  if (state.status == NewsListStatus.loadingMore) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 19,
                            vertical: 112 / 2,
                          ),
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    );
                  }

                  return SliverToBoxAdapter(child: const SizedBox());
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 96)),
            ],
          ),
        ),
      ),
    );
  }

  void _loadMore() {
    final filters = context.read<FiltersBloc>().state;
    context.read<NewsListBloc>().add(
      NextPageRequested(
        selectedCategory: filters.selectedCategory,
        searchQuery: filters.searchQuery,
      ),
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _PinnedHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(bottom: 8),
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
