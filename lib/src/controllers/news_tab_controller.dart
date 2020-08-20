import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:news_app/src/data/news_api.dart';
import 'package:news_app/src/data/persistent_database.dart';
import 'package:news_app/src/data/service_locator.dart';
import 'package:news_app/src/models/article.dart';

class NewsTabController extends ChangeNotifier {
  final PersistentSource source;
  NewsTabController(this.source) {
    scheduleMicrotask(firstLoad);
  }

  bool isLoading = true;
  int totalResults;
  List<Article> articles = [];
  bool isError = false;
  String errorMessage =
      'Something went wrong :(\n Please check your internet connection and try again.';
  int pageSize = 10;
  int get page => (articles?.length ?? 0) ~/ pageSize;

  Future<void> firstLoad() async {
            debugPrint('notifying for $source');
    isLoading = true;
    isError = false;
    notifyListeners();
    await loadArticles();
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadArticles() async {
    if (articles.length == totalResults) {
      return null;
    }
    try {
      await locator<NewsAPI>().getEverything(
        pageSize: pageSize,
        page: page + 1,
        sources: [source.id],
      ).then((response) {
        isError = false;
        totalResults = response.body.totalResults;
        articles.addAll(response.body.articles);
        notifyListeners();
      }, onError: (error) {
        isError = true;
        errorMessage = '$error';
        notifyListeners();
      });
    } catch (e) {
      isError = true;
      errorMessage = '$e';
      notifyListeners();
    }
  }
}
