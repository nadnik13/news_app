import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main/data/models/news_article.dart';

class NewsArticleItem extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final String? url = article.imageUrl;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFCECECE), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15), // цвет тени
            offset: Offset(0, 3), // смещение: x=0, y=4 — только вниз
            blurRadius: 6.1, // размытие тени
            spreadRadius: 0, // насколько тень распространяется
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/one_news/${article.id}'),
        // IntrinsicHeight тяжелый, можно избежать его использования,
        // если зафиксировать высоту карточки.
        child: IntrinsicHeight(
          child: Row(
            children: [
              if (url != null)
                Flexible(
                  flex: 123,
                  child: SizedBox.expand(
                    child: Image.network(url, fit: BoxFit.cover),
                  ),
                ),
              Flexible(
                flex: 322 - 123,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            article.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _formatDate(article.publishedAt),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime? dt) {
  if (dt == null) return '';
  final String mm = dt.month.toString().padLeft(2, '0');
  final String dd = dt.day.toString().padLeft(2, '0');
  return '$mm.$dd.${dt.year}';
}
