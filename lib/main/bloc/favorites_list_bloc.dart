import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/news_article.dart';
import '../infrastructure/repositories/favorites_list_repository.dart';

part '../data/models/favorites_event.dart';
part '../data/models/favorites_state.dart';

class FavoritesListBlock extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesListRepository repository;

  FavoritesListBlock({required this.repository})
    : super(const FavoritesState.initial()) {
    on<InitialFavoriteListRequested>(_onNewsInitial);
    on<FavoriteNewsAdded>(_onNewsAdded);
    on<FavoriteNewsRemoved>(_onNewsRemoved);
  }

  Future<void> _onNewsInitial(
    InitialFavoriteListRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    final next = await repository.fetchAll();
    emit(state.copyWith(articles: next));
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
