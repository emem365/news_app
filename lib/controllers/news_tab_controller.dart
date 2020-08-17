import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/data/news_api.dart';
import 'package:news_app/data/persistent_database.dart';
import 'package:news_app/data/service_locator.dart';
import 'package:news_app/models/article.dart';

class NewsTabController extends ChangeNotifier {
  final PersistentSource source;
  NewsTabController(this.source) {
    scheduleMicrotask(firstLoad);
  }

  bool isLoading = true;
  int totalResults;
  BuiltList<Article> articles;
  bool isError = false;
  String errorMessage = '';

  Future<void> firstLoad() async {
    isLoading = true;
    isError = false;
    notifyListeners();
    await loadArticles();
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadArticles() =>
      locator<NewsAPI>().getTopHeadlinesFromSource(source.id).then((response) {
        isError = false;
        totalResults = response.body.totalResults;
        articles = response.body.articles;
        notifyListeners();
      }, onError: (error) {
        isError = true;
        errorMessage = '$error';
        notifyListeners();
      });
}
