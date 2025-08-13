import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/favorites_list/bloc/favorites_list_bloc.dart';
import 'package:news_app/one_news/data/models/news_article.dart';

class OneNewsScreen extends StatefulWidget {
  final NewsArticle article;

  const OneNewsScreen({super.key, required this.article});

  @override
  State<OneNewsScreen> createState() => _OneNewsScreenState();
}

class _OneNewsScreenState extends State<OneNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesListBloc, FavoritesState>(
      builder: (context, favoritesState) {
        final isFavorite = favoritesState.articles.contains(widget.article);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      child: SizedBox(child: Image.asset('assets/exit.png')),
                    ),
                    Spacer(),
                    InkWell(
                      onTap:
                          () => context.read<FavoritesListBloc>().add(
                            isFavorite
                                ? FavoriteNewsRemoved(widget.article)
                                : FavoriteNewsAdded(widget.article),
                          ),
                      child:
                          isFavorite
                              ? SizedBox(
                                child: Image.asset('assets/filled_star.png'),
                              )
                              : SizedBox(child: Image.asset('assets/star.png')),
                    ),
                  ],
                ),

                Text(
                  '${widget.article.title}',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 33),
                ),
                Text('${widget.article.subtitle}'),
                Row(
                  children: [
                    Text(widget.article.source),
                    Text(widget.article.publishedAt.toString()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
