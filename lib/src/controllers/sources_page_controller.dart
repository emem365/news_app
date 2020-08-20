import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:news_app/src/data/news_api.dart';
import 'package:news_app/src/data/service_locator.dart';
import 'package:news_app/src/models/source.dart';

class SourcesPageController extends ChangeNotifier {
  SourcesPageController() {
    scheduleMicrotask(firstLoad);
  }
  bool showSelected = false;
  List<Source> sources;
  bool isError = false;
  String errorMessage =
      'Something went wrong :(\n Please check your internet connection and try again.';
  bool isLoading = true;

  Future<void> firstLoad() async {
    isLoading = true;
    isError = false;
    notifyListeners();
    await loadSources();
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadSources() async {
    try {
      await locator<NewsAPI>().getSources().then((response) {
        isError = false;
        sources = List.from(response.body.sources);
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

  void toggleShowSelected() {
    showSelected = !showSelected;
    notifyListeners();
  }
}
