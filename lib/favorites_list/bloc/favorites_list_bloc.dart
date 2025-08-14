import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      final next = await repository.fetchAll();
      emit(state.copyWith(articles: next, status: FavoritesStatus.success));
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
    final next = {...state.articles, event.article}.toList();
    emit(state.copyWith(articles: next));
    await repository.saveData(state.articles);
  }

  Future<void> _onNewsRemoved(
    FavoriteNewsRemoved event,
    Emitter<FavoritesState> emit,
  ) async {
    final next = state.articles.where((e) => e != event.article).toList();
    emit(state.copyWith(articles: next));
    await repository.saveData(state.articles);
  }
}
