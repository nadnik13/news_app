part of '../../blocks/filters_blocks.dart';

sealed class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object?> get props => [];
}

final class SearchQueryChanged extends FiltersEvent {
  final String query;
  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

final class FilterAdded extends FiltersEvent {
  final NewsCategory category;
  const FilterAdded(this.category);

  @override
  List<Object?> get props => [category];
}

final class FilterRemoved extends FiltersEvent {
  final NewsCategory category;
  const FilterRemoved(this.category);

  @override
  List<Object?> get props => [category];
}