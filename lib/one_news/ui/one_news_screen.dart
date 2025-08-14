import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/common/infrastructure/utils/date_format_extention.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/one_news/data/models/news_article.dart';

import '../../common/ui/star_widget.dart';

class OneNewsScreen extends StatelessWidget {
  final NewsArticle article;

  const OneNewsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.imageUrl;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: SizedBox(
                      child: Image.asset('assets/exit.png'),
                      width: 28,
                    ),
                  ),
                  Spacer(),
                  StarWidget(article: article),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 33,
                      ),
                    ),
                    Text(
                      article.subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 27,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          article.source,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                        Spacer(),
                        Text(
                          article.publishedAt.toText(
                            pattern:
                                AppLocalizations.of(context)?.date_pattern,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    if (imageUrl != null)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(27),
                          border: Border.all(
                            color: Color(0xFFCECECE),
                            width: 0.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: Offset(0, 3),
                              blurRadius: 6.1,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(imageUrl),
                      ),
                    Text(
                      article.text,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: 96),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
