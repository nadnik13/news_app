part of '../../bloc/favorites_list_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

final class InitialFavoriteListRequested extends FavoritesEvent {
  const InitialFavoriteListRequested();

  @override
  List<Object?> get props => [];
}

final class FavoriteNewsAdded extends FavoritesEvent {
  final NewsArticle article;

  const FavoriteNewsAdded(this.article);

  @override
  List<Object?> get props => [article];
}

final class FavoriteNewsRemoved extends FavoritesEvent {
  final NewsArticle article;

  const FavoriteNewsRemoved(this.article);

  @override
  List<Object?> get props => [article];
}
