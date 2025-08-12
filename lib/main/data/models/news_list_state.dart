part of '../../blocks/news_list_bloc.dart';

enum NewsListStatus { initial, loading, success, failure }

class NewsListState extends Equatable {
  final NewsListStatus status;
  final List<NewsArticle> items;
  final String? errorMessage;
  final int page;

  const NewsListState({
    required this.status,
    required this.items,
    required this.errorMessage,
    required this.page,
  });

  const NewsListState.initial()
    : status = NewsListStatus.initial,
      items = const [],
      errorMessage = null,
      page = 1;

  NewsListState copyWith({
    NewsListStatus? status,
    List<NewsArticle>? items,
    String? errorMessage,
    int? page,
  }) {
    return NewsListState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage, page];
}
