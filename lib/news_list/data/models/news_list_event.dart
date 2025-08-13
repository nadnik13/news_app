part of 'package:news_app/news_list/bloc/news_list_bloc.dart';

sealed class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object?> get props => [];
}

final class InitialNewsListRequested extends NewsListEvent {
  const InitialNewsListRequested();
}

final class NewsListWithFiltersRequested extends NewsListEvent {
  final NewsCategory? selectedCategory;
  final String? searchQuery;

  const NewsListWithFiltersRequested({
    required this.selectedCategory,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [searchQuery, selectedCategory];
}

final class NextPageRequested extends NewsListEvent {
  final NewsCategory? selectedCategory;
  final String? searchQuery;

  const NextPageRequested({required this.selectedCategory, this.searchQuery});

  @override
  List<Object?> get props => [searchQuery, selectedCategory];
}
