part of '../../bloc/filters_bloc.dart';

class FiltersState extends Equatable {
  final String searchQuery;
  final Set<NewsCategory> selectedCategories;

  const FiltersState({
    required this.searchQuery,
    required this.selectedCategories,
  });

  const FiltersState.initial()
    : searchQuery = '',
      selectedCategories = const {};

  FiltersState copyWith({
    String? searchQuery,
    Set<NewsCategory>? selectedCategories,
  }) {
    return FiltersState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [searchQuery, selectedCategories];
}
