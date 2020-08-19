import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_app/src/data/persistent_database.dart';
import 'package:news_app/src/data/service_locator.dart';

class SubscribedSourcesController extends ChangeNotifier {
  SubscribedSourcesController() {
    persistentSourcesSubscription = locator<PersistentDatabase>()
        .watchAllPersistentSources()
        .listen(onEvent, onError: onError);
  }
  List<PersistentSource> persistentSources;
  StreamSubscription<List<PersistentSource>> persistentSourcesSubscription;
  bool isError = false;
  String errorMessage = "";
  bool hasData = false;

  void onEvent(List<PersistentSource> persistentSourcesEvent) {
    if (persistentSourcesEvent != null) {
      hasData = true;
      persistentSources = persistentSourcesEvent;
      notifyListeners();
    }
  }

  void onError(Object error) {
    isError = true;
    errorMessage = error.toString();
    notifyListeners();
  }
}
