import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/news_list/data/models/news_category.dart';
import 'package:news_app/news_list/infrastructure/repositories/news_list_repository.dart';
import 'package:news_app/one_news/data/models/news_article.dart';
import 'package:stream_transform/stream_transform.dart';

part 'package:news_app/news_list/data/models/news_list_event.dart';
part 'package:news_app/news_list/data/models/news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final NewsListRepository repository;

  NewsListBloc({required this.repository})
    : super(const NewsListState.initial()) {
    on<InitialNewsListRequested>(_onInitialNewsListRequested);
    on<NewsListWithFiltersRequested>(
      _onNewsListWithFiltersRequested,
      transformer:
          (events, mapper) => events
              .debounce(const Duration(milliseconds: 350))
              .switchMap(mapper),
    );
    on<NextPageRequested>(_onNextPageRequested, transformer: droppable());
  }

  Future<void> _onInitialNewsListRequested(
    InitialNewsListRequested event,
    Emitter<NewsListState> emit,
  ) async {
    _resetPage(emit);
    await _loadNews(emit);
  }

  Future<void> _onNewsListWithFiltersRequested(
    NewsListWithFiltersRequested event,
    Emitter<NewsListState> emit,
  ) async {
    _resetPage(emit);
    emit(state.copyWith(status: NewsListStatus.loadingMoreForbidden));
    await _loadNews(
      emit,
      searchQuery: event.searchQuery,
      selectedCategory: event.selectedCategory,
    );
  }

  Future<void> _onNextPageRequested(
    NextPageRequested event,
    Emitter<NewsListState> emit,
  ) async {
    if (state.status == NewsListStatus.loadingMoreForbidden) {
      return;
    }
    final currentPage = state.page;
    emit(state.copyWith(page: currentPage + 1));
    await _loadMoreNews(
      emit,
      searchQuery: event.searchQuery,
      selectedCategory: event.selectedCategory,
    );
  }

  void _resetPage(Emitter<NewsListState> emit) => emit(state.copyWith(page: 1));

  Future<void> _loadNews(
    Emitter<NewsListState> emit, {
    String? searchQuery,
    NewsCategory? selectedCategory,
  }) async {
    emit(state.copyWith(status: NewsListStatus.loading));
    try {
      final items = await repository.getNews(
        page: state.page,
        searchQuery: searchQuery,
        category: selectedCategory,
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

  Future<void> _loadMoreNews(
    Emitter<NewsListState> emit, {
    String? searchQuery,
    NewsCategory? selectedCategory,
  }) async {
    emit(state.copyWith(status: NewsListStatus.loadingMore));
    try {
      final newItems = await repository.getNews(
        page: state.page,
        searchQuery: searchQuery,
        category: selectedCategory,
      );
      final currentItems = state.items;

      if (newItems.isEmpty) {
        emit(state.copyWith(status: NewsListStatus.loadingMoreForbidden));
        return;
      }

      emit(
        state.copyWith(
          status: NewsListStatus.success,
          items: [...currentItems, ...newItems],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NewsListStatus.loadingMoreFailure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
