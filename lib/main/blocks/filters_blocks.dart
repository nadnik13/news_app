import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/news_category.dart';

part '../data/models/filters_event.dart';
part '../data/models/filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(const FiltersState.initial()) {
    on<SearchQueryChanged>(_onSearchChanged);
    on<FilterAdded>(_onFilterAdded);
    on<FilterRemoved>(_onFilterRemoved);
  }

  void _onSearchChanged(SearchQueryChanged event, Emitter<FiltersState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onFilterAdded(FilterAdded event, Emitter<FiltersState> emit) {
    final next = {...state.selectedCategories, event.category}.toSet();
    emit(state.copyWith(selectedCategories: next));
  }

  void _onFilterRemoved(FilterRemoved event, Emitter<FiltersState> emit) {
    final next = state.selectedCategories.where((e)=> e != event.category).toSet();
    emit(state.copyWith(selectedCategories: next));
  }
}