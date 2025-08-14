part of 'package:news_app/favorites_list/bloc/favorites_list_bloc.dart';

enum FavoritesStatus { initial, success, failure }

class FavoritesState extends Equatable {
  final List<NewsArticle> articles;
  final FavoritesStatus status;
  final String? errorMessage;

  const FavoritesState({
    required this.articles,
    required this.status,
    required this.errorMessage,
  });

  const FavoritesState.initial()
    : articles = const [],
      status = FavoritesStatus.initial,
      errorMessage = null;

  FavoritesState copyWith({
    List<NewsArticle>? articles,
    FavoritesStatus? status,
    String? errorMessage,
  }) {
    return FavoritesState(
      articles: articles ?? this.articles,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [articles, status, errorMessage];
}
