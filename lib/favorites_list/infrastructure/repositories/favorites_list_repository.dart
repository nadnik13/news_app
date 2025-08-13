import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:news_app/one_news/data/models/news_article.dart';

abstract class FavoritesListRepository {
  Future<List<NewsArticle>> fetchAll();

  Future<void> saveData(List<NewsArticle> data);
}

class FavoritesListRepositoryImpl implements FavoritesListRepository {
  final _varName = 'list';

  FavoritesListRepositoryImpl();

  @override
  Future<List<NewsArticle>> fetchAll() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final listString = sharedPreferences.getStringList(_varName);
    return (listString ?? [])
        .map((a) => NewsArticle.fromJson(json.decode(a)))
        .whereType<NewsArticle>()
        .toList();
  }

  @override
  Future<void> saveData(List<NewsArticle> data) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String> usrList =
        data.map((item) => jsonEncode(item.toJson())).toList();
    sharedPreferences.setStringList(_varName, usrList);
  }
}
