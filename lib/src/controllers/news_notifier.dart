import 'package:flutter/foundation.dart';
import 'package:news_app/src/controllers/news_tab_controller.dart';
import 'package:news_app/src/controllers/subscribed_sources_controller.dart';

class NewsNotifier extends ChangeNotifier {
  NewsNotifier(){
    subscribedSourcesController = SubscribedSourcesController()
      ..addListener(onSourcesChange);
  }
  bool isLoading = true;
  SubscribedSourcesController subscribedSourcesController;
  List<NewsTabController> newsTabs;
  void onSourcesChange() {
    if (subscribedSourcesController.hasData) isLoading = false;
    newsTabs = subscribedSourcesController.persistentSources
        .map((source) => NewsTabController(source))
        .toList();
    notifyListeners();
  }
}
