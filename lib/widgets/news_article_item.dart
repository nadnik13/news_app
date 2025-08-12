import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main/data/models/news_article.dart';

class NewsArticleItem extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleItem({super.key, required this.article, onTab});

  @override
  Widget build(BuildContext context) {
    final url = article.imageUrl;
    final loadImage = url != null;
      return ListTile(
        leading: loadImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : null,
        title: Text(article.title),
        subtitle: Text(
          article.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () => context.go('/one_news/${article.id}'),
      );

  }
}