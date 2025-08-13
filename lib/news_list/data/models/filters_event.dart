part of 'package:news_app/news_list/bloc/filters_bloc.dart';

sealed class FiltersEvent {
  const FiltersEvent();
}

final class SearchQueryChanged extends FiltersEvent {
  final String query;

  const SearchQueryChanged(this.query);
}

final class FilterTapped extends FiltersEvent {
  final NewsCategory category;

  const FilterTapped(this.category);
}
