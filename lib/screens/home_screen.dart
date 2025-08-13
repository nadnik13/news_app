import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/widgets/bottom_menu.dart';
import 'package:news_app/widgets/news_article_item.dart';

import '../main/bloc/news_list_bloc.dart';
import '../widgets/filters_widget.dart';

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
          child: Stack(
            children: [
              CustomScrollView(
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
                                state.errorMessage ?? 'Ошибка загрузки',
                              ),
                            ),
                          );
                        }
                        if (state.status == NewsListStatus.success) {
                          if (state.items.isEmpty) {
                            return const SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(child: Text('Ничего не найдено')),
                            );
                          }
                          return SliverList.builder(
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              final item = state.items[index];
                              return NewsArticleItem(article: item);
                            },
                          );
                        }
                        return const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 96)),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BottomMenu(
                  selected: BottomTab.home,
                  onHomeTap: () {},
                  onFavoritesTap: () => context.go('/favorites'),
                ),
              ),
            ],
          ),
        ),
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

final json = <String, dynamic>{
  "status": "ok",
  "totalResults": 2,
  "articles": [
    {
      "source": {"id": "techcrunch", "name": "TechCrunch"},
      "author": "John Doe",
      "title": "Flutter 4.0 Released",
      "description":
          "Flutter 4.0 brings amazing new features for cross-platform development.",
      "url": "https://techcrunch.com/flutter-4-release",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/de7e/live/a986f000-761c-11f0-8071-1788c7e8ae0e.jpg",
      "publishedAt": "2025-08-12T10:00:00Z",
      "content":
          "Today, Flutter team announced the release of Flutter 4.0 with exciting updates...",
    },
    {
      "source": {"id": "bbc-news", "name": "BBC News"},
      "author": "Jane Smith",
      "title": "AI Revolution in 2025",
      "description":
          "AI technology continues to transform industries worldwide.",
      "url": "https://bbc.com/ai-revolution-2025",
      "urlToImage":
          "https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/de7e/live/a986f000-761c-11f0-8071-1788c7e8ae0e.jpg",
      "publishedAt": "2025-08-11T15:30:00Z",
      "content": "Artificial Intelligence has reached new heights in 2025...",
    },
  ],
  "code": null,
  "message": null,
};
