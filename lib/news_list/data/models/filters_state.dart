part of 'package:news_app/news_list/bloc/filters_bloc.dart';

class FiltersState extends Equatable {
  final String searchQuery;
  final NewsCategory? selectedCategory;

  const FiltersState({
    required this.searchQuery,
    required this.selectedCategory,
  });

  const FiltersState.initial() : searchQuery = '', selectedCategory = null;

  FiltersState copyWith({String? searchQuery, NewsCategory? selectedCategory}) {
    return FiltersState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [searchQuery, selectedCategory];
}
