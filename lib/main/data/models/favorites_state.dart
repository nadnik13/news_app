part of '../../bloc/favorites_list_bloc.dart';

class FavoritesState extends Equatable {
  final List<NewsArticle> articles;

  const FavoritesState({required this.articles});

  const FavoritesState.initial() : articles = const [];

  FavoritesState copyWith({List<NewsArticle>? articles}) {
    return FavoritesState(articles: articles ?? this.articles);
  }

  @override
  List<Object?> get props => [articles];
}
