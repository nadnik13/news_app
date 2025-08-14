import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../favorites_list/bloc/favorites_list_bloc.dart';
import '../../one_news/data/models/news_article.dart';

class StarWidget extends StatelessWidget {
  final NewsArticle article;

  const StarWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesListBloc, FavoritesState>(
      builder: (context, favoritesState) {
        final isFavorite = favoritesState.articles.contains(article);
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap:
                () => context.read<FavoritesListBloc>().add(
                  isFavorite
                      ? FavoriteNewsRemoved(article)
                      : FavoriteNewsAdded(article),
                ),
            child:
                isFavorite
                    ? SizedBox(child: Image.asset('assets/filled_star.png'))
                    : SizedBox(child: Image.asset('assets/star.png')),
          ),
        );
      },
    );
  }
}
