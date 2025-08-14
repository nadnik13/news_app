import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/common/infrastructure/utils/iterable_extension.dart';
import 'package:news_app/favorites_list/infrastructure/repositories/favorites_list_repository.dart';
import 'package:news_app/one_news/data/models/news_article.dart';

part 'package:news_app/favorites_list/data/models/favorites_event.dart';
part 'package:news_app/favorites_list/data/models/favorites_state.dart';

class FavoritesListBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesListRepository repository;

  FavoritesListBloc({required this.repository})
    : super(const FavoritesState.initial()) {
    on<InitialFavoriteListRequested>(_onNewsInitial);
    on<FavoriteNewsAdded>(_onNewsAdded);
    on<FavoriteNewsRemoved>(_onNewsRemoved);
  }

  Future<void> _onNewsInitial(
    InitialFavoriteListRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final news = await repository.fetchAll();
      await _updateFavoriteNews(news: news, emit: emit, saveToRepo: false);
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoritesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onNewsAdded(
    FavoriteNewsAdded event,
    Emitter<FavoritesState> emit,
  ) async {
    final news = {...state.articles, event.article}.toList();
    await _updateFavoriteNews(news: news, emit: emit);
  }

  Future<void> _onNewsRemoved(
    FavoriteNewsRemoved event,
    Emitter<FavoritesState> emit,
  ) async {
    final news = state.articles.where((e) => e != event.article).toList();
    await _updateFavoriteNews(news: news, emit: emit);
  }

  Future<void> _updateFavoriteNews({
    required List<NewsArticle> news,
    required Emitter<FavoritesState> emit,
    bool saveToRepo = true,
  }) async {
    emit(state.copyWith(articles: _sort(news)));
    if (saveToRepo) {
      await repository.saveData(state.articles);
    }
  }

  List<NewsArticle> _sort(List<NewsArticle> news) =>
      news.sorted((a, b) => b.publishedAt.compareTo(a.publishedAt));
}
