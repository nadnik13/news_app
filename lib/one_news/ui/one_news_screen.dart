import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/common/ui/star_widget.dart';
import 'package:news_app/one_news/data/models/news_article.dart';

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
          child: ListView(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: SizedBox(child: Image.asset('assets/exit.png')),
                  ),
                  Spacer(),
                  StarWidget(article: article),
                ],
              ),
              Text(
                article.title,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 33),
              ),
              Text(
                article.subtitle,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 27),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    article.source,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                  ),
                  Spacer(),
                  Text(
                    _formatDate(article.publishedAt),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                  ),
                ],
              ),
              if (imageUrl != null)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(27),
                    border: Border.all(color: Color(0xFFCECECE), width: 0.5),
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
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//:TODO убать
String _formatDate(DateTime? dt) {
  if (dt == null) return '';
  final String mm = dt.month.toString().padLeft(2, '0');
  final String dd = dt.day.toString().padLeft(2, '0');
  return '$mm.$dd.${dt.year}';
}
