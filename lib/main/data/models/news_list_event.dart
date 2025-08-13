part of '../../bloc/news_list_bloc.dart';

sealed class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object?> get props => [];
}

final class InitialNewsListRequested extends NewsListEvent {
  const InitialNewsListRequested();
}

final class NewsListWithFiltersRequested extends NewsListEvent {
  final Set<NewsCategory> selectedCategories;
  final String? searchQuery;

  const NewsListWithFiltersRequested({
    required this.selectedCategories,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [searchQuery, selectedCategories];
}

final class NextPageRequested extends NewsListEvent {
  final Set<NewsCategory> selectedCategories;
  final String? searchQuery;

  const NextPageRequested({required this.selectedCategories, this.searchQuery});
}
