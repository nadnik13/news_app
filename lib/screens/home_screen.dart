import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/widgets/categories_row_widget.dart';
import 'package:news_app/widgets/news_article_item.dart';
import 'package:news_app/widgets/search_widget.dart';

import '../main/blocks/filters_blocks.dart';
import '../main/blocks/news_list_bloc.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocListener<FiltersBloc, FiltersState>(
                listener: (context, filtersState) {
                  context.read<NewsListBloc>().add(
                    NewsListWithFiltersRequested(
                      searchQuery: filtersState.searchQuery,
                      selectedCategories: filtersState.selectedCategories,
                    ),
                  );
                },
                child: Column(
                  children: [SearchWidget(), CategoriesRowWidget()],
                ),
              ),
              Expanded(
                child: BlocBuilder<NewsListBloc, NewsListState>(
                  builder: (context, state) {
                    if (state.status == NewsListStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == NewsListStatus.failure) {
                      return Center(
                        child: Text(state.errorMessage ?? 'Ошибка загрузки'),
                      );
                    }
                    if (state.status == NewsListStatus.success) {
                      if (state.items.isEmpty) {
                        return const Center(child: Text('Ничего не найдено'));
                      }
                      return ListView.separated(
                        itemCount: state.items.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          // TODO: подумать как сделать хорошо
                          // if (index == state.items.length - 3) {
                          //   final filters = context.read<FiltersBloc>().state;
                          //   context.read<NewsListBloc>().add(
                          //     NextPageRequested(
                          //       selectedCategories: filters.selectedCategories,
                          //       searchQuery: filters.searchQuery,
                          //     ),
                          //   );
                          // }

                          final item = state.items[index];
                          return NewsArticleItem(article: item);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
