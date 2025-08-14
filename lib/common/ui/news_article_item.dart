import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/common/infrastructure/utils/date_format_extention.dart';
import 'package:news_app/one_news/data/models/news_article.dart';

import 'star_widget.dart';

class NewsArticleItem extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onTap;
  final bool showStar;

  const NewsArticleItem({
    super.key,
    required this.article,
    required this.onTap,
    required this.showStar,
  });

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
        onTap: () => onTap(),
        // IntrinsicHeight тяжелый, можно избежать его использования,
        // если зафиксировать высоту карточки.
        child: IntrinsicHeight(
          child: Row(
            children: [
              if (url != null)
                Flexible(
                  flex: 123,
                  child: SizedBox.expand(
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) => const SizedBox(),
                    ),
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
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
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
                              if (showStar)
                                SizedBox(
                                  height: 32,
                                  child: StarWidget(article: article),
                                ),
                            ],
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
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            article.publishedAt.toText(
                              pattern:
                                  AppLocalizations.of(context)?.date_pattern,
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
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
