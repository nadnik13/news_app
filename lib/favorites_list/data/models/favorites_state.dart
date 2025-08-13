part of 'package:news_app/favorites_list/bloc/favorites_list_bloc.dart';

class FavoritesState extends Equatable {
  final List<NewsArticle> articles;

  const FavoritesState({required this.articles});

  const FavoritesState.initial() : articles = const [];

  FavoritesState copyWith({List<NewsArticle>? articles}) {
    print("copyWith: ${articles?.length}");
    return FavoritesState(articles: articles ?? this.articles);
  }

  @override
  List<Object?> get props => [articles];
}
