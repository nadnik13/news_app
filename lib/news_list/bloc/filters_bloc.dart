import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/news_list/data/models/news_category.dart';

part 'package:news_app/news_list/data/models/filters_event.dart';
part 'package:news_app/news_list/data/models/filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(const FiltersState.initial()) {
    on<SearchQueryChanged>(_onSearchChanged);
    on<FilterTapped>(_onFilterTapped);
  }

  void _onSearchChanged(SearchQueryChanged event, Emitter<FiltersState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onFilterTapped(FilterTapped event, Emitter<FiltersState> emit) {
    final needRemove = state.selectedCategory == event.category;
    if (needRemove) {
      final newState = FiltersState(
        searchQuery: state.searchQuery,
        selectedCategory: null,
      );
      emit(newState);
    } else {
      emit(state.copyWith(selectedCategory: event.category));
    }
  }
}
