import 'dart:convert';

import 'package:news_app/one_news/data/models/news_article.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesListRepository {
  Future<List<NewsArticle>> fetchAll();

  Future<void> saveData(List<NewsArticle> data);
}

class FavoritesListRepositoryImpl implements FavoritesListRepository {
  final SharedPreferences storage;
  final _varName = 'list';

  FavoritesListRepositoryImpl({required this.storage});

  @override
  Future<List<NewsArticle>> fetchAll() async {
    final listString = storage.getStringList(_varName);
    return (listString ?? [])
        .map((a) => NewsArticle.fromJson(json.decode(a)))
        .whereType<NewsArticle>()
        .toList();
  }

  @override
  Future<void> saveData(List<NewsArticle> data) async {
    List<String> usrList =
        data.map((item) => jsonEncode(item.toJson())).toList();
    storage.setStringList(_varName, usrList);
  }
}
