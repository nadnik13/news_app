import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../data/models/news_article.dart';
import '../data/models/news_category.dart';
import '../infrastructure/repositories/news_list_repository.dart';

part '../data/models/news_list_event.dart';
part '../data/models/news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final NewsListRepository repository;

  NewsListBloc({required this.repository})
    : super(const NewsListState.initial()) {
    on<InitialNewsListRequested>(_onRequested);
    on<NewsListWithFiltersRequested>(
      _onRequestedDebounced,
      transformer:
          (events, mapper) => events
              .debounce(const Duration(milliseconds: 350))
              .switchMap(mapper),
    );
    on<NextPageRequested>(_onNextPageRequested);
  }

  Future<void> _onRequested(
    InitialNewsListRequested event,
    Emitter<NewsListState> emit,
  ) async {
    await _performFetch(emit, selectedCategories: const {});
  }

  Future<void> _onRequestedDebounced(
    NewsListWithFiltersRequested event,
    Emitter<NewsListState> emit,
  ) async {
    await _performFetch(
      emit,
      searchQuery: event.searchQuery,
      selectedCategories: event.selectedCategories,
    );
  }

  Future<void> _onNextPageRequested(
    NextPageRequested event,
    Emitter<NewsListState> emit,
  ) async {
    final currentPage = state.page;
    emit(state.copyWith(page: currentPage + 1));
    await _performFetch(
      emit,
      searchQuery: event.searchQuery,
      selectedCategories: event.selectedCategories,
    );
  }

  Future<void> _performFetch(
    Emitter<NewsListState> emit, {
    String? searchQuery,
    Set<NewsCategory>? selectedCategories,
  }) async {
    emit(state.copyWith(status: NewsListStatus.loading));
    try {
      final items = await repository.getNews(
        page: state.page,
        searchQuery: searchQuery ?? '',
        categories: selectedCategories ?? const {},
      );
      emit(state.copyWith(status: NewsListStatus.success, items: items));
    } catch (e) {
      emit(
        state.copyWith(
          status: NewsListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
